require 'logger'
require 'gitki/renderers/renderer'
require 'gitki/backend'
require 'gitki/attributes'
require 'gitki/page'
require 'gitki/history'
require 'gitki/index'
require 'confstruct'

module Gitki

  # base class that dimplement gitki wrkflow using various other component
  #
  class Gitki

    attr_accessor :renderer
    attr_accessor :site_path, :source_path
    attr_accessor :logger


    def initialize(source_path,opts={})
      @source_path = source_path
      @source_path = File.expand_path(@source_path)
      @site_path = opts[:to] || File.join(@source_path, "site")
      @source_path =File.expand_path(@source_path)
      @logger = Logger.new(STDOUT)
      @backend = Backend.new(@source_path)
      @renderer = if render = opts.delete(:renderer)
        Renderer.get render
      else
        Renderer::Full.new
      end
    end

    def read_configuration(cfg_path = nil)
      cfg_path ||= File.join(@source_path, "config.rb")
      @configuration = if File.exist?(cfg_path)
        eval(File.read(cfg_path))
      else
        Confstruct::Configuration.new
      end
    end

    def self.configuration(&block)
      yield Confstruct::Configuration.new
    end

    def generate(opts={})
      create_site
      generate_history
      convert
      generate_index
    end

    def convert
      files.each do |page|
        page[:rev] = @backend.revision page.path
        write_file(page_name(page.name), @renderer.render_page(page))
      end
    end

    # Generate an index file containing all file present in directory
    def generate_index
      write_file("index.html", @renderer.render_page(Index.new(pages)))
    end

    #git log --pretty=oneline --abbrev-commit  --follow  gestion-proj.md
    def generate_history
      hist = File.join(@source_path, "history.md")
      FileUtils.rm(hist) if File.exist?(hist)
      data = files.inject({}) do |acc, page|
        acc[page.name] = @backend.history(page.path)
        acc
      end
      history = History.new(data)
      page = @renderer.render_page history
      write_file "history.html", page
    end

    def create_site
      FileUtils.rm_r @site_path if File.exist?(@site_path)
      FileUtils.mkdir_p @site_path
      FileUtils.mkdir(File.join(@site_path, "assets"))
      @renderer.assets.each do |asset|
        FileUtils.cp asset, File.join(@site_path, "assets")
      end
    end

    private

    # use git log --abbrev-commit --pretty=oneline  -n1 -- gestion-proj.md to get the last comit that change a file
    def extract_metadata(file)
      meta = {
        :file => File.basename(file),
        :title => File.basename(file),
        :last_modified => File.mtime(file).strftime("%d/%m/%Y a %H:%M"),
        :rev => @backend.revision(file)
      }
      meta
    end

    def files
      @pages ||= @backend.files.map { |file| Page.new(file) }
    end

    def page_name path
      name = File.basename(path, ".*")
      name << ".html"
    end

    def write_file name, content
      logger.info "Generate #{name}"
      File.open(File.join(@site_path, name), "w+") do |file|
        file << content
      end
    end

  end

end


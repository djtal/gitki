require 'gitki/renderers/renderer'
require 'gitki/backend'
require 'confstruct'

module Gitki

  # base class that dimplement gitki wrkflow using various other component
  #
  class Gitki

    attr_accessor :renderer
    attr_accessor :site_path, :source_path


    def initialize(source_path,opts={})
      @source_path = source_path
      @source_path = File.expand_path(@source_path)
      @site_path = opts[:to] || File.join(@source_path, "site")
      @source_path =File.expand_path(@source_path)
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
      files.each do |file|
        file_path = File.join(@source_path, file)
        page = @renderer.render_page File.read(file_path), extract_metadata(file_path)
        write_file page_name(file), page
      end
    end

    # Generate an index file containing all file present in directory
    def generate_index
      content = files.inject("") do |page,entry|
        page << "* [#{File.basename entry, ".*" }](#{page_name entry})\n"
        page
      end
      page = @renderer.render_page content, {:file => "", :toc => false, :title => "Acceuil", :last_modified => Time.now.to_s, :rev => %x[cd #{@source_path} && git rev-parse --short HEAD]}
      write_file "index.html", page
    end

    #git log --pretty=oneline --abbrev-commit  --follow  gestion-proj.md
    def generate_history
      hist = File.join(@source_path, "history.md")
      FileUtils.rm(hist) if File.exist?(hist)
      history = {}
      files.each do |file|
        history[file] = @backend.history(file)
      end
      content = history.inject("") do |page, (file, hist)|
        page << "## #{file} ##\n\n"
        hist.each_line do |line|
          page << "* #{line}"
        end
        page << "\n\n"
        page
      end
      page = @renderer.render_page content, {:file => "", :toc => false, :title => "Historique", :last_modified => Time.now.to_s, :rev => @backend.last_revision}
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
        :file => file,
        :title => File.basename(file),
        :last_modified => File.mtime(file).strftime("%d/%m/%Y a %H:%M"),
        :rev => @backend.revision(file)
      }
      meta
    end

    def files
      @backend.files
    end

    def page_name path
      name = File.basename(path, ".*")
      name << ".html"
    end

    def write_file name, content
      File.open(File.join(@site_path, name), "w+") do |file|
        file << content
      end
    end

  end

end


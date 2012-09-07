require "thor"
require "gitki"

module Gitki

  class CLI < Thor
    desc "generate", "Generate the html version of the wiki"
    option :from, :default => ".", :banner => "directory containg the source md file for the wiki"
    option :to, :banner => "destination directory where all the wiki will generated"
    option :renderer, :banner => "used the passed theme to generate the site"
    def generate
      from = File.expand_path(options[:from] )
      ki = Gitki.new(options[:from], :to => options[:to])
      ki.generate
    end

    desc "themes", "List installed themes"
    def themes
      Renderer::Renderer.list.each do |render|
      	p render
      end
    end
  end

end

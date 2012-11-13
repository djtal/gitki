require 'redcarpet'
require 'tilt'
require 'gitki/renderers/full/custom_markdown'
require 'active_support/core_ext/object/blank'
require 'gemoji'

module Gitki

  module Renderer

    # render the site with a full html temlpaet and markdonw converted into html
    # Use RdCarpet to first cnver markdwon to html
    # and then wrap it into a good looking page store in a erb template
    class Full < Renderer
      attr_accessor :template
      attr_accessor :resources_path


      def initialize
        renderer = CustomMarkdown.new(:with_toc_data => true)
        @converter = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true, :no_intra_emphasis => true  )
        @toc = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC.new)
        @resources_path = File.dirname(File.expand_path(__FILE__))
      end

      # API : convert a mardonw page to an complete html page
      def render_page(page, opts = {})
        toc = opts.delete(:toc)
        toc ||= true
        page[:body] = @converter.render(page.content).to_s
        title = @converter.renderer.headers.first
        page[:title] = title unless title.blank? || page.keep_title
        page[:toc] = @toc.render(page.content) if toc
        template.render page
      end

      # API : Return the list of assets: js, css, images to copy into site
      def assets
        @assets ||= Dir[File.join(@resources_path, "assets", "*.{js,css,ttf,eot,svg,woff,png,jpeg}")]
        @assets << Dir[File.join(Emoji.images_path, "emoji", "*.png")]
        @assets
      end

      private

      def template
        unless @template
          template = File.join(@resources_path, "templates", "page.haml")
          if File.exist? template
            @template = Tilt.new(template)
          else
            raise Error
          end
        end
        @template
      end
    end

  end

end

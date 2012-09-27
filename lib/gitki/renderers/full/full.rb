require 'redcarpet'
require 'tilt'
require 'gitki/renderers/full/pygment_markdown'
require 'active_support/core_ext/object/blank'

module Gitki

  module Renderer

    # render the site with a full html temlpaet and markdonw converted into html
    # Use RdCarpet to first cnver markdwon to html
    # and then wrap it into a good looking page store in a erb template
    class Full < Renderer
      attr_accessor :template
      attr_accessor :resources_path

      def initialize
        renderer = PygmentMarkdown.new(:with_toc_data => true)
        @converter = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true, :no_intra_emphasis => true  )
        @toc = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC.new)
        @resources_path = File.dirname(File.expand_path(__FILE__))
      end

      # API : convert a mardonw page to an complete html page
      def render_page(file, opts = {})
        toc = opts.delete(:toc)
        toc ||= true
        content = @converter.render(file)
        title = @converter.renderer.headers.first
        context = {
          :body => content,
          :code_css => PygmentMarkdown.code_css,
        }.merge(opts)
        context[:title] = title unless title.blank?
        context[:toc] = @toc.render(file) if toc
        template.render self, context
      end

      # API : Return the list of assets: js, css, images to copy into site
      def assets
        @assets ||= Dir[File.join(@resources_path, "assets", "*.{js,css,ttf,eot,svg,woff,png,jpeg}")]
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

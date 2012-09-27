require 'pygments.rb'
require 'active_support/core_ext/string/inflections'

module Gitki
  module Renderer
    class PygmentMarkdown < Redcarpet::Render::HTML
      attr_reader :code_css
      attr_reader :title
      attr_reader :headers

      def self.code_css
        Pygments.css('.highlight')
      end

      def block_code(code, language)
        Pygments.highlight(code, :lexer => language)
      end


      def header(text, header_level)
        @num ||= -1
        @headers << text
        id = text.gsub("\s", "-").dasherize.downcase
        "<h#{header_level} id=\"toc_#{@num += 1}\">#{text}</h#{header_level}>"
      end

      def preprocess(full_document)
        @headers = []
        full_document
      end
    end
  end
end

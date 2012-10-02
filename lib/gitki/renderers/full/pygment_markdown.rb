require 'pygments.rb'
require 'active_support/core_ext/string/inflections'

module Gitki
  module Renderer
    class PygmentMarkdown < Redcarpet::Render::HTML
      attr_reader :code_css
      attr_reader :title
      attr_reader :headers

      EMOJI_PATTERN = %r{(:(\S+):)}.freeze

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
        parse_emoji full_document
      end

      def postprocess(full_document)
        full_document
      end


      private

      def parse_emoji(text)
        text.gsub!(EMOJI_PATTERN) do |match|
          "<img class='emoji' src='emojis/#{$2}.png' width='20' alt='#{$1}'></img>"
        end
        text
      end
    end
  end
end

require 'pygments.rb'

module Gitki
  module Renderer
    class PygmentMarkdown < Redcarpet::Render::HTML
      attr_reader :code_css
      attr_reader :title

      def self.code_css
	Pygments.css('.highlight')
      end


      def block_code(code, language)
	Pygments.highlight(code, :lexer => language)
      end
    end
  end
end

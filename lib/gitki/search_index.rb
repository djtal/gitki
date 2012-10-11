require 'multy_json'
require 'oj'

module Gitki

  class SearchIndex
    attr_reader :index_json

    def initialize(pages)
      @pages = pages
    end

    def inverted_index
      @data = {}
      @pages.each do |page|
        @page[page.name] = page.content.split.map do |token|
          token.downcase.gsub(/\W/, '')
        end
      end
      @index_json = MultiJson.dump(@data)
    end

    def search_page

    end

  end

end

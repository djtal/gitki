require 'multi_json'
require 'oj'

module Gitki

  class SearchIndex
    attr_reader :index_json

    def initialize
      @data = {}
    end

    def inverted_index
      @pages.each do |page|
        page.content.split.map do |line|
          line.split.downcase.gsub(/\W/, '').each do |word|
            @data[word] ||= []
            @data[word] << page.name
          end
        end
      end
      @index_json = MultiJson.dump(@data)
    end

    def add_page_to_index page_name, content

    end

    def index
      @data
    end

  end

end

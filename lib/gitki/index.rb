module Gitki
  # Actualy converty output from a git log to a markdonw version
  # This version is the converted to regular html by the rest of the sytem
  #
  class Index
    include Attributes
    attr_accessor :data

    METADATA = {
      :show_toc => false,
      :keep_title => true,
      :title => "Acceuil"
    }

    attr_accessor :git_data

    def initialize(content, opts = {})
      @data = content
    end

    def content
      content = data.inject("") do |page, entry|
        page << "* [#{entry[0]}](#{entry[1]})\n"
        page
      end
      content
    end
  end
end

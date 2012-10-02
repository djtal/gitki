module Gitki
  # Actualy converty output from a git log to a markdonw version
  # This version is the converted to regular html by the rest of the sytem
  #
  class History
    include Attributes
    attr_accessor :git_data

    METADATA = {
      :show_toc => false,
      :keep_title => true,
      :title => 'Historique des modifications'
    }

    attr_accessor :git_data

    def initialize(content, opts = {})
      @git_data = content
    end

    def content
      content = @git_data.inject("") do |page, (file, hist)|
        page << "## #{file}\n\n"
        hist.each_line do |line|
          page << "* #{line}"
        end
        page << "\n\n"
        page
      end
      content
    end
  end
end

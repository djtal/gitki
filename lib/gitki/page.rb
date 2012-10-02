module Gitki

  # A page hold all data for each page to convert
  # it old the content and all associted metadata need
  # this class can serve as a scope for template rendering. So irendering can search through all available information
  # in this class
  #
  class Page
    attr_accessor :path, :name
    attr_accessor :revision
    attr_accessor :content

    def initialize(path)
      @path = path
    end

    def content
      @content ||= File.read(path)
    end

    def metadata
      @metadata ||= {
        :file => File.basename(@path),
        :title => File.basename(@path),
        :last_modified => File.mtime(@path).strftime("%d/%m/%Y a %H:%M")
      }
    end

    def []=(key, value)
      @metadata[key] = value
    end

    def name
      metadata[:file]
    end

    def method_missing(m, *args)
      if value = metadata[m.to_sym]
        value
      else
        super(m, args)
      end
    end

  end


end

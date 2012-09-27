module Gitki

  # Keep git operation isalted from the rest of application so we can use different backed if need
  # Do all the dirty work of converting git ouput to ruby object
  class Backend
    attr_accessor :source_path

    def initialize(path)
      @source_path = path
    end

    # May be base on git to only inlcude versionned files
    # see output of git ls-files
    # filtered with a *.md regexp to only include mardown files
    def files
      @files ||= %x[cd #{@source_path} && git ls-files].split("\n").grep(/.*\.md$/)
      @files
    end

    def revision(file)
      %x[cd #{@source_path} && git log -n1 --abbrev-commit --pretty=oneline -- #{file}]
    end

    def history(file)
      %x[cd #{@source_path} && git log --pretty=format:"%h - %an, %ar : %s" -- #{file}]
    end

    def last_revision
      %x[cd #{@source_path} && git rev-parse --short HEAD]
    end

  end
end

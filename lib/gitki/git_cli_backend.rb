module Gitki

  # Keep git operation isalted from the rest of application so we can use different backed if need
  # Do all the dirty work of converting git ouput to ruby object
  class GitCliBackend
    attr_accessor :source_path

    def initialize(path)
      @source_path = path
    end

    # May be base on git to only inlcude versionned files
    # see output of git ls-files
    # filtered with a *.md regexp to only include mardown files
    def files
      @files ||= %x[cd #{@source_path} && git ls-files].split("\n").grep(/.*\.md$/)
      @files.map! { |file|  file }
    end

    def revision(file)
      co = %x[cd #{@source_path} && git log -n1  --pretty=oneline -- #{file}]
      data = co.split(" ")
      { data.shift => data.join(" ") }
    end

    def history(file)
      data = %x[cd #{@source_path} && git log --pretty=format:"%H %s" -- #{file}]
      hist = {}
      puts data
      data.each_line do |commit|
        sha, msg = parse_commit(commit)
        hist[sha] = msg
      end
      hist
    end

    def last_revision
      co = %x[cd #{@source_path} && git log -n1  --pretty=oneline]
      data = co.split(" ")
      { data.shift => data.join(" ") }
    end

    def file(path, revision = nil)
      return File.read(File.join(@source_path, path)) unless revision
      %x[cd #{@source_path} && git show #{revision}:#{path}]
    end

    private

    def parse_commit(commit)
      co = commit.split(" ")
      return co.shift,  co.join(" ")
    end

  end
end

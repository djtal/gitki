require "rugged"

module Gitki
  class RuggedBackend
    def initialize(path)
     @repo = Rugged::Repository.new(path)
    end

    def last_revision
      head = @repo.lookup(@repo.head.target)
      { @repo.head.target => head.message }
    end

    def revision(file)
      obj = @repo.index.select { |obj| obj[:path] == file }.first
      raise "#{file} don't exist in repository" unless obj
      commit = @repo.lookup(obj[:oid])
      { obj[:oid] => commit.message }
    end

    def files
      @repo.index.map { |obj| obj[:path] }
    end

    def file(path)
      obj = @repo.index.select { |obj| obj[:path] == path }.first
      raise "#{file} don't exist in repository" unless obj
      blob = @repo.lookup obj[:oid]
      blob.content
    end

  end
end

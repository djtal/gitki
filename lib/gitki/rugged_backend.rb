require "rugged"

module Gitki
  class RuggedBackend
    def initialize(path)
     @repo = Rugged::Repositiry.new(path)
    end

  end
end

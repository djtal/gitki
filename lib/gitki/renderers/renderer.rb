require 'active_support/core_ext/string/inflections'

module Gitki
  module Renderer
    class Renderer
      @renderers = []

      def self.list
       @renderers.map { |render| render.name.demodulize.underscore}
      end

      def self.inherited(subclass)
        super
        @renderers << subclass unless @renderers.include?(subclass)
        subclass
      end

    end
  end

end


require File.join(File.dirname(File.expand_path(__FILE__)), 'full','full')
require File.join(File.dirname(File.expand_path(__FILE__)), 'strapdown_js','strapdown_js')


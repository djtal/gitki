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

      def self.get name, opts = {}
	raise Error unless list.include? name
	kls = name.constantize
	o.new opts
      end

    end
  end

end


require File.join(File.dirname(File.expand_path(__FILE__)), 'full','full')
require File.join(File.dirname(File.expand_path(__FILE__)), 'strapdown_js','strapdown_js')


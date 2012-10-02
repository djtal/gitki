require  'active_support/concern'
require 'active_support/core_ext/string/inflections'

module Gitki

  module Attributes
    extend ActiveSupport::Concern

    included do
    end


    module InstanceMethods
      def metadata
        @metadata ||= {
            :file => self.class.to_s.downcase,
            :title => self.class.to_s.downcase,
            :last_modified => Time.now,
            :rev => "",
            :show_toc => false
        }.merge(self.class::METADATA || {})
      end

      def []=(key, value)
        self.metadata[key] = value
      end

      end

      def method_missing(m, *args)
        if self.metadata[m.to_sym] != nil
          self.metadata[m.to_sym]
        else
          super(m, args)
        end
      end
    end

end

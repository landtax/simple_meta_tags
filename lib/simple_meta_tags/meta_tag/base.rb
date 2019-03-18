module SimpleMetaTags
  module MetaTag
    class Base
      attr_accessor :aliased

      def initialize(attributes)
        @attributes = attributes
      end

      def aliases(meta)
        self.aliased = meta
      end

      def attributes
        if aliased
          aliased.attributes
        else
          @attributes
        end
      end

      def render_attributes_in_tag
        @attributes.to_a.map {|k,v| "#{k}='#{v}'"}.join(" ")
      end
    end
  end
end

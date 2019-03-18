module SimpleMetaTags
  module MetaTag
    class Generic < Base

      def initialize(name, content)
        super({'name' => name, 'content' => content})
      end

      def self.build(meta_id, options)
        return new(meta_id, options)
      end

      def render
        "<meta #{render_attributes_in_tag} />"
      end
    end
  end
end

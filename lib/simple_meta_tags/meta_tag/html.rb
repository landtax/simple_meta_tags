module SimpleMetaTags
  module MetaTag
    class Html < Base

      def initialize(name, content)
        super({'name' => name, 'content' => content})
      end

      def self.build(meta_id, options)
        return new(meta_id, options)
      end

      def to_html
        "<#{attributes['name']}>#{attributes['content']}</#{attributes['name']}>"
      end
    end
  end
end

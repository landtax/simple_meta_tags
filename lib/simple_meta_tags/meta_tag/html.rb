module SimpleMetaTags
  module MetaTag
    class Html < Base

      def initialize(name, content)
        super({'name' => name, 'content' => content})
      end

      def self.build(meta_id, options)
        return unless valid_meta?(meta_id)

        new(meta_id, options)
      end

      def to_html
        "<#{attributes['name']}>#{attributes['content']}</#{attributes['name']}>"
      end

      private

      def self.valid_meta?(meta_id)
        %w(title).include? meta_id
      end
    end
  end
end

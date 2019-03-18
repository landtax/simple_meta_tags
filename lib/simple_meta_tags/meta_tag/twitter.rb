module SimpleMetaTags
  module MetaTag
    class Twitter < Base

      def initialize(name, content)
        super({'name' => name, 'content' => content})
      end

      def self.build(meta_id, options)
        return unless valid_meta?(meta_id)

        new(meta_id, options)
      end

      def to_html
        "<meta #{render_attributes_in_tag} />"
      end

      private

      def self.valid_meta?(meta_id)
        meta_id.to_s.start_with?('twitter:')
      end
    end
  end
end

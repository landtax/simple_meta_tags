module SimpleMetaTags
  module MetaTag
    class OpenGraph < Base

      def initialize(property, content)
        super({'property' => property, 'content' => content})
      end

      def self.build(meta_id, options)
        return unless valid_meta?(meta_id)

        new(meta_id, options)
      end

      def render
        "<meta #{render_attributes_in_tag} />"
      end

      private

      def self.valid_meta?(meta_id)
        meta_id.to_s.start_with?('og:')
      end
    end
  end
end

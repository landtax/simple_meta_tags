module SimpleMetaTags
  module MetaTag
    class HttpEquiv < Base

      def initialize(name, content)
        super({'http-equiv' => name, 'content' => content})
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
        %w(X-UA-Compatible content-type default-style refresh).include? meta_id
      end
    end
  end
end

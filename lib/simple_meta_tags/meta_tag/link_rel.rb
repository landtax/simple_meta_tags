module SimpleMetaTags
  module MetaTag
    class LinkRel < Base

      def initialize(rel, attributes)
        attributes = { 'href' =>  attributes } unless attributes.is_a? Hash
        super({'rel' => rel}.merge(attributes))
      end

      def self.build(meta_id, options)
        return unless valid_meta?(meta_id)

        new(meta_id, options)
      end

      def to_html
        "<link #{render_attributes_in_tag} />"
      end

      private

      def self.valid_meta?(meta_id)
        %w(alternate author canonical dns-prefetch help icon license next
           pingback preconnect prefetch preload prev search stylesheet).include? meta_id
      end
    end
  end
end

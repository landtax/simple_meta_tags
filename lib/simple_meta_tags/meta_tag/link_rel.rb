module SimpleMetaTags
  module MetaTag
    class LinkRel < Base

      attr_accessor :rel_type, :lang

      def initialize(meta_id, attributes)
        @rel_type = meta_id_type(meta_id)
        @lang = meta_id_lang(meta_id)

        base_attributes = if @lang
                            { 'hreflang' => @lang }
                          else
                            {}
                          end


        param_attributes = if attributes.is_a? Hash
                             attributes
                           else
                             {'href' =>  attributes }
                           end

        super(base_attributes.merge(param_attributes))
      end

      def self.build(meta_id, options)
        return unless valid_meta?(meta_id)

        new(meta_id, options)
      end

      def to_html
        "<link #{rel_html} #{render_attributes_in_tag} />"
      end

      private

      def meta_id_type(meta_id)
        meta_id.split(':')[1]
      end

      def meta_id_lang(meta_id)
        meta_id.split(':')[2]
      end

      def rel_html
        "rel='#{@rel_type}'"
      end

      def self.valid_meta?(meta_id)
        meta_id.to_s.start_with?('rel:')
      end
    end
  end
end

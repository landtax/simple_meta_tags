module SimpleMetaTags
  class Document

    attr_reader :tags, :aliases, :required_meta

    def initialize
      @tags = {}
      @aliases = {}
      @required_meta = []
    end

    def meta(meta_id, options=nil)
      return meta_id.map { |id| meta(id, options) } if meta_id.is_a? Array

      new_meta = build_meta(meta_id, options)
      raise ArgumentError.new('Only String or Array') unless new_meta

      tags[meta_id] = new_meta
    end

    def html_tags(separator="\n")
      raise MetaTagMissing.new("Missing tags: #{missing_meta}")  if meta_missing?

      tags.values.map(&:to_html).join(separator)
    end

    def require(meta_ids)
      @required_meta += [meta_ids].flatten
    end

    def optional(meta_ids)
      @required_meta -= [meta_ids].flatten
    end

    def alias(alias_id)
      aliases[alias_id] = self.aliases[alias_id] || Alias.new
    end

    private

    def meta_missing?
      missing_meta.any?
    end

    def missing_meta
      @required_meta - tags.keys
    end

    def build_meta(meta_id, options)
      MetaTag::Html.build(meta_id, options) ||
      MetaTag::HttpEquiv.build(meta_id, options) ||
      MetaTag::OpenGraph.build(meta_id, options) ||
      MetaTag::Twitter.build(meta_id, options) ||
      MetaTag::Generic.build(meta_id, options)
    end
  end
end

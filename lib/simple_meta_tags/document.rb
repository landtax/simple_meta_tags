module SimpleMetaTags
  class Document

    attr_reader :tags, :aliases

    def initialize
      @tags = {}
      @aliases = {}
    end

    def meta(meta_id, options=nil)
      return meta_id.map { |id| meta(id, options) } if meta_id.is_a? Array

      new_meta = build_meta(meta_id, options)
      raise ArgumentError.new('Only Strings or Array') unless new_meta

      tags[meta_id] = new_meta
    end

    def alias(alias_id)
      aliases[alias_id] = self.aliases[alias_id] || Alias.new
    end

    def html_tags(separator="\n")
      tags.values.map(&:render).join(separator)
    end

    private

    def build_meta(meta_id, options)
      MetaTag::OpenGraph.build(meta_id, options) ||
      MetaTag::Generic.build(meta_id, options)
    end
  end
end

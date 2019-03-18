module SimpleMetaTags
  class Alias < Array
    attr_accessor :attributes
    attr_reader :tags

    def initialize
      @tags = []
      super
    end

  end
end

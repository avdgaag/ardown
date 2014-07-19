module Ardown
  class TextNode
    attr_reader :content
    private :content

    def initialize(content)
      @content = content
    end

    def inspect
      "#<TextNode:0x%s %s>" % [__id__.to_s(16), content]
    end

    def to_html
      content
    end
  end
end

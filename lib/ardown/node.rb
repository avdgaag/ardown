module Ardown
  class Node < RootNode
    attr_reader :type, :attributes

    def initialize(type = :div, attributes = {})
      super()
      @type       = type
      @attributes = AttributeList.new.merge!(attributes)
      yield self if block_given?
    end

    def inspect
      format(
        "#<Node:0x%s %s %s %s>",
        __id__.to_s(16),
        type,
        attributes.inspect,
        inspected_children
      )
    end

    def block?
      %i(div p h1 h2 h3 h4 h5 h6 li inline_li ul ol pre blockquote).include?(type)
    end

    def wrapping_block?
      %i(blockquote ul ol li).include?(type)
    end

    def singular?
      %i(img).include?(type)
    end

    def to_html
      if singular?
        format('<%s%s>', tag_name, attributes.to_html)
      else
        format(
          '<%s%s>%s%s</%s>%s',
          tag_name,
          attributes.to_html,
          inner_whitespace,
          TextHelpers.indent(super, width: indentation),
          tag_name,
          outer_whitespace
        )
      end
    end

    private

    def tag_name
      type == :inline_li ? :li : type
    end

    def indentation
      wrapping_block? ? 4 : 0
    end

    def inner_whitespace
      wrapping_block? ? $/ : ''
    end

    def outer_whitespace
      block?  ? $/ * 2 : ''
    end
  end
end

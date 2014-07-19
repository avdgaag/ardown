module Ardown
  class Document
    include Grammar

    attr_reader :references, :ast

    def initialize(str)
      @references = {}
      @ast = parse_blocks(parse_and_strip_references(str))
    end

    def to_html
      ast.to_html
    end

    private

    def create_inline_node(tag, content, options = {})
      Node.new(tag, options).push(*parse_inline(content))
    end

    def parse_inline(str)
      element =
        case str
        when STRONG
          create_inline_node(:strong, $2)
        when EM
          create_inline_node(:em, $2)
        when IMG
          Node.new(:img, src: $2, alt: $1)
        when ANCHOR_INLINE
          create_inline_node(:a, $1, href: $2, title: $3)
        when ANCHOR_REF
          create_inline_node(:a, $1, references[$2 || $1])
        else
          TextNode.new(str)
        end

      if element.is_a?(TextNode)
        [element]
      else
        [*parse_inline($`), element, *parse_inline($')]
      end
    end

    def parse_blocks(str, root = RootNode.new)
      current_list = nil
      current_item = nil
      str.chomp.split(/\n\n/).each do |source|
        node =
          case source
          when HEADING
            current_list = current_item = nil
            Node.new(:"h#{$1.length}") do |n|
              n.push(*parse_inline($2))
            end
          when SUB_BLOCK
            parse_blocks(TextHelpers.remove_prefix(source, UL_LI_LINE), current_item)
            nil
          when BLOCK_OL_LI
            current_list ||= Node.new :ol
            li = Node.new(:li) do |l|
              parse_blocks(TextHelpers.remove_prefix(source, OL_LI_LINE), l)
            end
            current_item = li
            current_list << li
            current_list
          when BLOCK_UL_LI
            current_list ||= Node.new :ul
            li = Node.new(:li) do |l|
              parse_blocks(TextHelpers.remove_prefix(source, UL_LI_LINE), l)
            end
            current_item = li
            current_list << li
            current_list
          when UL_LI
            parse_into_list :ul, UL_LI, source
          when OL_LI
            parse_into_list :ol, OL_LI, source
          when BLOCKQUOTE
            current_list = current_item = nil
            nested_content = TextHelpers.remove_prefix(source, BLOCKQUOTE_LINE)
            Node.new(:blockquote) do |blockquote|
              parse_blocks(nested_content, blockquote)
            end
          when PRE
            current_list = current_item = nil
            Node.new(:pre) do |pre|
              pre << create_inline_node(:code, TextHelpers.remove_prefix(source, PRE_LINE))
            end
          else
            current_list = current_item = nil
            Node.new(:p).push(*parse_inline(source))
          end
        root << node if node && !root.include?(node)
      end
      root
    end

    def parse_into_list(type, sep, str)
      Node.new(type) do |ol|
        str.split(sep).map(&:chomp).drop(1).each do |txt|
          ol << Node.new(:inline_li).push(*parse_inline(txt))
        end
      end
    end

    def parse_and_strip_references(str)
      str.gsub(REFERENCE) do |m|
        references[$1] = { href: $2, title: $3 }
        ''
      end
    end
  end
end

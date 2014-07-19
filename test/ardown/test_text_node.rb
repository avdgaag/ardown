require_relative '../minitest_helper'
require 'ardown/text_node'

class TestTextNode < Minitest::Test
  def setup
    @node = Ardown::TextNode.new 'hello, world'
  end

  def test_uses_content_to_convert_to_html
    assert_equal 'hello, world', @node.to_html
  end

  def test_inspects_with_the_content
    assert_match(/#<TextNode:\S+ hello, world>/, @node.inspect)
  end
end

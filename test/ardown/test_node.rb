require_relative '../minitest_helper'
require 'ardown/node'
require 'ardown/attribute_list'
require_relative 'shared_node_tests'

class TestNode < Minitest::Test
  include SharedNodeTests

  def setup
    @node = Ardown::Node.new
  end

  def test_defaults_to_div
    assert_equal :div, @node.type
  end

  def test_defaults_to_empty_attribute_list
    assert_equal Ardown::AttributeList.new, @node.attributes
  end

  def test_yields_self_given_a_block
    yielded_node = nil
    node = Ardown::Node.new do |n|
      yielded_node = n
    end
    assert_same node, yielded_node
  end

  def test_considers_html_block_level_elements_block
    %i(div p h1 h2 h3 h4 h5 h6 li inline_li ul ol pre blockquote).each do |type|
      assert Ardown::Node.new(type).block?
    end
  end

  def test_considers_quotes_and_lists_wrapping_blocks
    %i(blockquote ul ol li).each do |type|
      assert Ardown::Node.new(type).wrapping_block?
    end
  end

  def test_considers_an_image_a_singular_element
    assert Ardown::Node.new(:img).singular?
  end

  def test_renders_self_closing_tag_with_attributes_for_img
    assert_equal "<img src='foo'>", Ardown::Node.new(:img, src: 'foo').to_html
  end

  def test_renders_inline_element_without_whitespace_and_with_child_nodes
    node = Ardown::Node.new(:a, href: 'foo')
    node << Ardown::TextNode.new('bar')
    assert_equal "<a href='foo'>bar</a>", node.to_html
  end

  def test_renders_block_level_elements_with_outer_whitespace
    node = Ardown::Node.new(:p)
    node << Ardown::TextNode.new('bar')
    assert_equal "<p>bar</p>\n\n", node.to_html
  end

  def test_renders_wrapping_block_elements_with_inner_and_outer_whitespace_and_indentation
    blockquote = Ardown::Node.new(:blockquote)
    p = Ardown::Node.new(:p)
    blockquote << p
    p << Ardown::TextNode.new('bar')
    assert_equal "<blockquote>\n    <p>bar</p>\n    \n</blockquote>\n\n", blockquote.to_html
  end

  def test_renders_inline_li_as_li
    assert_equal "<li></li>\n\n", Ardown::Node.new(:inline_li).to_html
  end
end

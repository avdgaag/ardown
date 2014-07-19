require_relative '../minitest_helper'
require 'ardown/attribute_list'

class TestAttributeList < MiniTest::Test
  def setup
    @attributes = Ardown::AttributeList.new
  end

  def test_converts_to_html_attributes
    @attributes['title'] = 'hello'
    @attributes['href'] = '#bla'
    assert_equal " title='hello' href='#bla'", @attributes.to_html
  end

  def test_converts_empty_list_to_empty_string
    assert_equal '', @attributes.to_html, 'string is not empty'
  end

  def test_it_escapes_values
    @attributes['title'] = "It's a great title"
    assert_equal " title='It&quot;s a great title'", @attributes.to_html
  end
end

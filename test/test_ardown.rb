require_relative './minitest_helper'

class TestArdown < MiniTest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ardown::VERSION
  end

  def test_it_can_convert_a_document
    md = File.read('test/fixtures/page.md')
    html = File.read('test/fixtures/page.html')
    assert_equal html, Ardown::Document.new(md).to_html
  end
end

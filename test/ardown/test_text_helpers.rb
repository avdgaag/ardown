require_relative '../minitest_helper'
require 'ardown/text_helpers'

class TestTextHelpers < Minitest::Test
  include Ardown::TextHelpers

  def test_it_indents_all_lines_in_a_string_with_four_spaces_by_default
    assert_equal "    foo\n    bar", indent("foo\nbar")
  end

  def test_allows_custom_indentation_width_and_chars
    assert_equal "**foo\n**bar", indent("foo\nbar", width: 2, char: '*')
  end

  def test_removes_trailing_whitespace_from_all_lines
    assert_equal "foo\nbar\n", strip_trailing_whitespace("foo  \nbar\n")
  end

  def test_indicates_whether_all_lines_start_with_a_string
    assert all_lines_start_with?("> foo\n> bar", '> ')
    refute all_lines_start_with?("> foo\n> bar", ' >')
  end

  def test_indicates_whether_all_lines_match_a_regex
    assert all_lines_match?("> foo\n> bar", / /)
    refute all_lines_match?("> foo\n> bar", /oo/)
  end

  def test_removes_a_shared_prefix_from_all_lines
    assert_equal "foo\nbar", remove_prefix("> foo\n> bar", '> ')
  end

  def test_removes_blank_lines_from_string
    assert_equal "foo\nbar", remove_blank_lines("foo\n\nbar")
  end
end

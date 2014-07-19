module Ardown
  module TextHelpers
    module_function

    def indent(str, width: 4, char: ' ')
      str.gsub(/^/, char * width)
    end

    def strip_trailing_whitespace(str)
      str.gsub(/ *$/m, '')
    end

    def all_lines_start_with?(str, prefix)
      all_lines_match?(str, /^#{prefix}/)
    end

    def all_lines_match?(str, regex)
      str.lines.all? { |line| line =~ regex }
    end

    def remove_prefix(str, prefix)
      str.lines.map { |line| line.sub(prefix, '') }.join
    end

    def remove_blank_lines(str)
      str.lines.grep(/\S/).join
    end
  end
end

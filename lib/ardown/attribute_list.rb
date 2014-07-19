module Ardown
  # Special kind of Hash that has a {to_html} method to convert itself to a a
  # string of valid HTML attributes.
  class AttributeList < Hash
    # Transform into a validly formatted string of HTML attributes.
    #
    # @example
    #   AttributeList['href', 'example.com'].to_html
    #   # => " href='example.com'"
    #
    # @return [String] string of HTML tag attributes
    def to_html
      return '' unless any?
      map { |attribute, value|
        format " %s='%s'", attribute, (value || '').gsub("'", '&quot;')
      }.join
    end
  end
end

# Ardown

Ardown is a very simple implementation of [Markdown][]. It supports minimal
syntax and formatting, but it works for documents I write. Due to its minimal
functionality, it is also quite fast.

Ardown is a hobby project and should probably not be used in production
environments.

[Markdown]: http://daringfireball.net/projects/markdown

## Installation

Add this line to your application's Gemfile:

    gem 'ardown'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ardown

## Usage

The gem contains an executable so you can use it from the command line:

    $ ardown path/to/document.md > document.html

In your Ruby project, you can create a new `Document` and convert it to HTML:

    require 'ardown'
    Ardown::Document.new('## Heading 2').to_html # => "<h2>Heading 2</h2>\n"

Since Ardown parses Markdown into an AST that is then rendered as HTML, it
should be trivial to extend it to support other output formats.

## Contributing

1. Fork it (https://github.com/avdgaag/ardown/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Credits

Created by: Arjan van der Gaag  
URL: [http://arjanvandergaag.nl](http://arjanvandergaag.nl)  
Project homepage: [http://avdgaag.github.com/ardown](http://avdgaag.github.com/ardown)  
Date: July 2014
License: [MIT-license](https://github.com/avdgaag/ardown/LICENSE.txt) (same as Ruby)

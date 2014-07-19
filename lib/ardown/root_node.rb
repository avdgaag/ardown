require 'forwardable'

module Ardown
  class RootNode
    include Enumerable

    attr_reader :children
    private :children

    extend Forwardable
    def_delegators :children, :empty?, :include?, :size

    def initialize
      @children = []
    end

    def push(*args)
      children.push(*args)
      self
    end
    alias_method :<<, :push

    def each
      return to_enum(__callee__) unless block_given?
      children.each { |child| yield child }
      self
    end

    def to_html
      TextHelpers.strip_trailing_whitespace(children.map(&:to_html).join)
    end

    def inspect
      format(
        '#<RootNode:0x%s%s>',
        __id__.to_s(16),
        inspected_children
      )
    end

    private

    def inspected_children
      return '' unless children.any?
      $/ + TextHelpers.indent(children.map(&:inspect).join($/)) + $/
    end
  end
end

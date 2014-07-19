require_relative '../minitest_helper'
require 'ardown/root_node'
require_relative 'shared_node_tests'

class TestRootNode < Minitest::Test
  include SharedNodeTests

  def setup
    @node = Ardown::RootNode.new
  end
end

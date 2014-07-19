module SharedNodeTests
  def test_has_no_children_by_default
    assert_empty @node
  end

  def test_iterates_over_all_children
    @node << 'bla'
    i = 0
    @node.each do |child|
      assert_equal 'bla', child
      i += 1
    end
    assert_equal 1, i, 'Expected to have yielded only once'
  end

  def test_returns_itself_after_iteration
    ret = @node.each { }
    assert_equal @node, ret
  end

  def test_returns_enumerator_without_a_block
    assert_kind_of Enumerator, @node.each
  end

  def test_adds_multiple_children
    @node.push 'foo', 'bar'
    assert_equal 2, @node.size
  end

  def test_returns_self_after_pushing
    assert_same @node, @node.push('foo', 'bar')
  end

  def test_shovels_children
    @node << 'foo' << 'bar'
    assert_equal 2, @node.size
  end

  def test_indicates_whether_it_includes_a_child
    @node << 'foo'
    assert @node.include?('foo')
  end
end

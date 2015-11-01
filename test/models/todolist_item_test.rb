require 'test_helper'

class TodolistItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @one = todolist_items(:one)
    @two = todolist_items(:two)
    @removed = todolist_items(:removed)
  end

  test "content" do
    assert_equal "Hello", @one.content
    assert_equal "World", @two.content
    assert_equal "Removed", @removed.content
  end

  test "completed" do
    assert_equal false, @one.completed
    assert_equal true, @two.completed
    assert_equal false, @removed.completed
  end

  test "removed" do
    assert_equal false, @one.removed
    assert_equal false, @two.removed
    assert_equal true, @removed.removed
  end
end

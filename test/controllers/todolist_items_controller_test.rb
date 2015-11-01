require 'test_helper'

class TodolistItemsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "show should succeed" do
    get(:show, id: "1", format: :json)
    assert_response :success
    assert_not_nil assigns(:todolist_item)
    json_body = JSON.parse(response.body)
    assert_equal 1, json_body["id"]
    assert_equal "Hello", json_body["content"]
  end

  test "create should succeed" do
    get(:create, todolist_item: { content: "random content" }, format: :json)
    assert_response :success
    json_body = JSON.parse(response.body)
    assert_not_nil json_body["id"]
    assert_equal "random content", json_body["content"]
  end

  test "update should succeed" do
    put(:update, id: "1", todolist_item: { content: "olleH" }, format: :json)
    assert_response :success
    json_body = JSON.parse(response.body)
    assert_equal 1, json_body["id"]
    assert_equal "olleH", json_body["content"]
  end

  test "destroy should succeed" do
    delete(:destroy, id: "1", format: :json)
    assert_response :success
  end
end

require 'test_helper'

class StreamsControllerTest < ActionController::TestCase
  setup do
    @stream = streams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:streams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stream" do
    assert_difference('Stream.count') do
      post :create, :stream => @stream.attributes
    end

    assert_redirected_to stream_path(assigns(:stream))
  end

  test "should show stream" do
    get :show, :id => @stream.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @stream.to_param
    assert_response :success
  end

  test "should update stream" do
    put :update, :id => @stream.to_param, :stream => @stream.attributes
    assert_redirected_to stream_path(assigns(:stream))
  end

  test "should destroy stream" do
    assert_difference('Stream.count', -1) do
      delete :destroy, :id => @stream.to_param
    end

    assert_redirected_to streams_path
  end
end

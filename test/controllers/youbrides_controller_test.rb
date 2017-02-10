require 'test_helper'

class YoubridesControllerTest < ActionController::TestCase
  setup do
    @youbride = youbrides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:youbrides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create youbride" do
    assert_difference('Youbride.count') do
      post :create, youbride: {  }
    end

    assert_redirected_to youbride_path(assigns(:youbride))
  end

  test "should show youbride" do
    get :show, id: @youbride
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @youbride
    assert_response :success
  end

  test "should update youbride" do
    patch :update, id: @youbride, youbride: {  }
    assert_redirected_to youbride_path(assigns(:youbride))
  end

  test "should destroy youbride" do
    assert_difference('Youbride.count', -1) do
      delete :destroy, id: @youbride
    end

    assert_redirected_to youbrides_path
  end
end

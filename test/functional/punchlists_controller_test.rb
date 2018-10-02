require 'test_helper'

class PunchlistsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:punchlists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create punchlist" do
    assert_difference('Punchlist.count') do
      post :create, :punchlist => { }
    end

    assert_redirected_to punchlist_path(assigns(:punchlist))
  end

  test "should show punchlist" do
    get :show, :id => punchlists(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => punchlists(:one).to_param
    assert_response :success
  end

  test "should update punchlist" do
    put :update, :id => punchlists(:one).to_param, :punchlist => { }
    assert_redirected_to punchlist_path(assigns(:punchlist))
  end

  test "should destroy punchlist" do
    assert_difference('Punchlist.count', -1) do
      delete :destroy, :id => punchlists(:one).to_param
    end

    assert_redirected_to punchlists_path
  end
end

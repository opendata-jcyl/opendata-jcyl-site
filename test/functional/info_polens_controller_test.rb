require 'test_helper'

class InfoPolensControllerTest < ActionController::TestCase
  setup do
    @info_polen = info_polens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:info_polens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create info_polen" do
    assert_difference('InfoPolen.count') do
      post :create, info_polen: { FECHA: @info_polen.FECHA }
    end

    assert_redirected_to info_polen_path(assigns(:info_polen))
  end

  test "should show info_polen" do
    get :show, id: @info_polen
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @info_polen
    assert_response :success
  end

  test "should update info_polen" do
    put :update, id: @info_polen, info_polen: { FECHA: @info_polen.FECHA }
    assert_redirected_to info_polen_path(assigns(:info_polen))
  end

  test "should destroy info_polen" do
    assert_difference('InfoPolen.count', -1) do
      delete :destroy, id: @info_polen
    end

    assert_redirected_to info_polens_path
  end
end

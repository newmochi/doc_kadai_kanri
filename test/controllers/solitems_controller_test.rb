require 'test_helper'

class SolitemsControllerTest < ActionController::TestCase
  setup do
    @solitem = solitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solitem" do
    assert_difference('Solitem.count') do
      post :create, solitem: { req_id: @solitem.req_id, saction: @solitem.saction, scontent: @solitem.scontent, slevel: @solitem.slevel, snote: @solitem.snote, snotedetail: @solitem.snotedetail, sphase: @solitem.sphase, starget: @solitem.starget, stitle: @solitem.stitle, user_id: @solitem.user_id }
    end

    assert_redirected_to solitem_path(assigns(:solitem))
  end

  test "should show solitem" do
    get :show, id: @solitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @solitem
    assert_response :success
  end

  test "should update solitem" do
    patch :update, id: @solitem, solitem: { req_id: @solitem.req_id, saction: @solitem.saction, scontent: @solitem.scontent, slevel: @solitem.slevel, snote: @solitem.snote, snotedetail: @solitem.snotedetail, sphase: @solitem.sphase, starget: @solitem.starget, stitle: @solitem.stitle, user_id: @solitem.user_id }
    assert_redirected_to solitem_path(assigns(:solitem))
  end

  test "should destroy solitem" do
    assert_difference('Solitem.count', -1) do
      delete :destroy, id: @solitem
    end

    assert_redirected_to solitems_path
  end
end

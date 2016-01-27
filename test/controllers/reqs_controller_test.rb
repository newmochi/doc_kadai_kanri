require 'test_helper'

class ReqsControllerTest < ActionController::TestCase
  setup do
    @req = reqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create req" do
    assert_difference('Req.count') do
      post :create, req: { rchap: @req.rchap, rcontent: @req.rcontent, rnote: @req.rnote, rnotedetail: @req.rnotedetail, rsec: @req.rsec, rseqno: @req.rseqno, rsubsec: @req.rsubsec, rtitile: @req.rtitile, user_id: @req.user_id }
    end

    assert_redirected_to req_path(assigns(:req))
  end

  test "should show req" do
    get :show, id: @req
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @req
    assert_response :success
  end

  test "should update req" do
    patch :update, id: @req, req: { rchap: @req.rchap, rcontent: @req.rcontent, rnote: @req.rnote, rnotedetail: @req.rnotedetail, rsec: @req.rsec, rseqno: @req.rseqno, rsubsec: @req.rsubsec, rtitile: @req.rtitile, user_id: @req.user_id }
    assert_redirected_to req_path(assigns(:req))
  end

  test "should destroy req" do
    assert_difference('Req.count', -1) do
      delete :destroy, id: @req
    end

    assert_redirected_to reqs_path
  end
end

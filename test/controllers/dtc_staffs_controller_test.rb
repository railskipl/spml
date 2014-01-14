require 'test_helper'

class DtcStaffsControllerTest < ActionController::TestCase
  setup do
    @dtc_staff = dtc_staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dtc_staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dtc_staff" do
    assert_difference('DtcStaff.count') do
      post :create, dtc_staff: { consumer_id: @dtc_staff.consumer_id, user_id: @dtc_staff.user_id }
    end

    assert_redirected_to dtc_staff_path(assigns(:dtc_staff))
  end

  test "should show dtc_staff" do
    get :show, id: @dtc_staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dtc_staff
    assert_response :success
  end

  test "should update dtc_staff" do
    patch :update, id: @dtc_staff, dtc_staff: { consumer_id: @dtc_staff.consumer_id, user_id: @dtc_staff.user_id }
    assert_redirected_to dtc_staff_path(assigns(:dtc_staff))
  end

  test "should destroy dtc_staff" do
    assert_difference('DtcStaff.count', -1) do
      delete :destroy, id: @dtc_staff
    end

    assert_redirected_to dtc_staffs_path
  end
end

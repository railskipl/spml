require 'test_helper'

class MeterStatusesControllerTest < ActionController::TestCase
  setup do
    @meter_status = meter_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meter_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meter_status" do
    assert_difference('MeterStatus.count') do
      post :create, meter_status: { billing_meter_status: @meter_status.billing_meter_status }
    end

    assert_redirected_to meter_status_path(assigns(:meter_status))
  end

  test "should show meter_status" do
    get :show, id: @meter_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meter_status
    assert_response :success
  end

  test "should update meter_status" do
    patch :update, id: @meter_status, meter_status: { billing_meter_status: @meter_status.billing_meter_status }
    assert_redirected_to meter_status_path(assigns(:meter_status))
  end

  test "should destroy meter_status" do
    assert_difference('MeterStatus.count', -1) do
      delete :destroy, id: @meter_status
    end

    assert_redirected_to meter_statuses_path
  end
end

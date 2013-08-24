require 'test_helper'

class MeterReaderStatusesControllerTest < ActionController::TestCase
  setup do
    @meter_reader_status = meter_reader_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meter_reader_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meter_reader_status" do
    assert_difference('MeterReaderStatus.count') do
      post :create, meter_reader_status: { description: @meter_reader_status.description }
    end

    assert_redirected_to meter_reader_status_path(assigns(:meter_reader_status))
  end

  test "should show meter_reader_status" do
    get :show, id: @meter_reader_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meter_reader_status
    assert_response :success
  end

  test "should update meter_reader_status" do
    patch :update, id: @meter_reader_status, meter_reader_status: { description: @meter_reader_status.description }
    assert_redirected_to meter_reader_status_path(assigns(:meter_reader_status))
  end

  test "should destroy meter_reader_status" do
    assert_difference('MeterReaderStatus.count', -1) do
      delete :destroy, id: @meter_reader_status
    end

    assert_redirected_to meter_reader_statuses_path
  end
end

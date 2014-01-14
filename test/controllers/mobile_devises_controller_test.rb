require 'test_helper'

class MobileDevisesControllerTest < ActionController::TestCase
  setup do
    @mobile_devise = mobile_devises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobile_devises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobile_devise" do
    assert_difference('MobileDevise.count') do
      post :create, mobile_devise: { imei: @mobile_devise.imei, manufacturer_name: @mobile_devise.manufacturer_name, phone_no: @mobile_devise.phone_no, purchase_date: @mobile_devise.purchase_date }
    end

    assert_redirected_to mobile_devise_path(assigns(:mobile_devise))
  end

  test "should show mobile_devise" do
    get :show, id: @mobile_devise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobile_devise
    assert_response :success
  end

  test "should update mobile_devise" do
    patch :update, id: @mobile_devise, mobile_devise: { imei: @mobile_devise.imei, manufacturer_name: @mobile_devise.manufacturer_name, phone_no: @mobile_devise.phone_no, purchase_date: @mobile_devise.purchase_date }
    assert_redirected_to mobile_devise_path(assigns(:mobile_devise))
  end

  test "should destroy mobile_devise" do
    assert_difference('MobileDevise.count', -1) do
      delete :destroy, id: @mobile_devise
    end

    assert_redirected_to mobile_devises_path
  end
end

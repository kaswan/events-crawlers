require 'test_helper'

class ExeoJapansControllerTest < ActionController::TestCase
  setup do
    @exeo_japan = exeo_japans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exeo_japans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exeo_japan" do
    assert_difference('ExeoJapan.count') do
      post :create, exeo_japan: { address: @exeo_japan.address, age_range_for_female: @exeo_japan.age_range_for_female, age_range_for_male: @exeo_japan.age_range_for_male, all_images_link: @exeo_japan.all_images_link, description: @exeo_japan.description, eligibility_for_female: @exeo_japan.eligibility_for_female, eligibility_for_male: @exeo_japan.eligibility_for_male, event_date_time: @exeo_japan.event_date_time, event_url: @exeo_japan.event_url, important_reminder: @exeo_japan.important_reminder, main_image_url: @exeo_japan.main_image_url, postalcode: @exeo_japan.postalcode, prefecture_name: @exeo_japan.prefecture_name, price_for_female: @exeo_japan.price_for_female, price_for_male: @exeo_japan.price_for_male, reservation_state_for_female: @exeo_japan.reservation_state_for_female, reservation_state_for_male: @exeo_japan.reservation_state_for_male, title: @exeo_japan.title, venue_name: @exeo_japan.venue_name }
    end

    assert_redirected_to exeo_japan_path(assigns(:exeo_japan))
  end

  test "should show exeo_japan" do
    get :show, id: @exeo_japan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exeo_japan
    assert_response :success
  end

  test "should update exeo_japan" do
    patch :update, id: @exeo_japan, exeo_japan: { address: @exeo_japan.address, age_range_for_female: @exeo_japan.age_range_for_female, age_range_for_male: @exeo_japan.age_range_for_male, all_images_link: @exeo_japan.all_images_link, description: @exeo_japan.description, eligibility_for_female: @exeo_japan.eligibility_for_female, eligibility_for_male: @exeo_japan.eligibility_for_male, event_date_time: @exeo_japan.event_date_time, event_url: @exeo_japan.event_url, important_reminder: @exeo_japan.important_reminder, main_image_url: @exeo_japan.main_image_url, postalcode: @exeo_japan.postalcode, prefecture_name: @exeo_japan.prefecture_name, price_for_female: @exeo_japan.price_for_female, price_for_male: @exeo_japan.price_for_male, reservation_state_for_female: @exeo_japan.reservation_state_for_female, reservation_state_for_male: @exeo_japan.reservation_state_for_male, title: @exeo_japan.title, venue_name: @exeo_japan.venue_name }
    assert_redirected_to exeo_japan_path(assigns(:exeo_japan))
  end

  test "should destroy exeo_japan" do
    assert_difference('ExeoJapan.count', -1) do
      delete :destroy, id: @exeo_japan
    end

    assert_redirected_to exeo_japans_path
  end
end

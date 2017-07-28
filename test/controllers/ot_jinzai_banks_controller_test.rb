require 'test_helper'

class OtJinzaiBanksControllerTest < ActionController::TestCase
  setup do
    @ot_jinzai_bank = ot_jinzai_banks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ot_jinzai_banks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ot_jinzai_bank" do
    assert_difference('OtJinzaiBank.count') do
      post :create, ot_jinzai_bank: { corporate_name: @ot_jinzai_bank.corporate_name, employment_type: @ot_jinzai_bank.employment_type, holiday_vacation: @ot_jinzai_bank.holiday_vacation, institution_type: @ot_jinzai_bank.institution_type, job_category: @ot_jinzai_bank.job_category, job_detail: @ot_jinzai_bank.job_detail, job_feature: @ot_jinzai_bank.job_feature, nearest_station: @ot_jinzai_bank.nearest_station, office_name: @ot_jinzai_bank.office_name, page_url: @ot_jinzai_bank.page_url, postalcode: @ot_jinzai_bank.postalcode, prefecture: @ot_jinzai_bank.prefecture, recommended_comment: @ot_jinzai_bank.recommended_comment, salary: @ot_jinzai_bank.salary, sub_title: @ot_jinzai_bank.sub_title, title: @ot_jinzai_bank.title, work_location: @ot_jinzai_bank.work_location, working_hours: @ot_jinzai_bank.working_hours, workplace_feature: @ot_jinzai_bank.workplace_feature }
    end

    assert_redirected_to ot_jinzai_bank_path(assigns(:ot_jinzai_bank))
  end

  test "should show ot_jinzai_bank" do
    get :show, id: @ot_jinzai_bank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ot_jinzai_bank
    assert_response :success
  end

  test "should update ot_jinzai_bank" do
    patch :update, id: @ot_jinzai_bank, ot_jinzai_bank: { corporate_name: @ot_jinzai_bank.corporate_name, employment_type: @ot_jinzai_bank.employment_type, holiday_vacation: @ot_jinzai_bank.holiday_vacation, institution_type: @ot_jinzai_bank.institution_type, job_category: @ot_jinzai_bank.job_category, job_detail: @ot_jinzai_bank.job_detail, job_feature: @ot_jinzai_bank.job_feature, nearest_station: @ot_jinzai_bank.nearest_station, office_name: @ot_jinzai_bank.office_name, page_url: @ot_jinzai_bank.page_url, postalcode: @ot_jinzai_bank.postalcode, prefecture: @ot_jinzai_bank.prefecture, recommended_comment: @ot_jinzai_bank.recommended_comment, salary: @ot_jinzai_bank.salary, sub_title: @ot_jinzai_bank.sub_title, title: @ot_jinzai_bank.title, work_location: @ot_jinzai_bank.work_location, working_hours: @ot_jinzai_bank.working_hours, workplace_feature: @ot_jinzai_bank.workplace_feature }
    assert_redirected_to ot_jinzai_bank_path(assigns(:ot_jinzai_bank))
  end

  test "should destroy ot_jinzai_bank" do
    assert_difference('OtJinzaiBank.count', -1) do
      delete :destroy, id: @ot_jinzai_bank
    end

    assert_redirected_to ot_jinzai_banks_path
  end
end

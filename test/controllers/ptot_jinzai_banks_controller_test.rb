require 'test_helper'

class PtotJinzaiBanksControllerTest < ActionController::TestCase
  setup do
    @ptot_jinzai_bank = ptot_jinzai_banks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ptot_jinzai_banks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ptot_jinzai_bank" do
    assert_difference('PtotJinzaiBank.count') do
      post :create, ptot_jinzai_bank: { corporate_name: @ptot_jinzai_bank.corporate_name, employment_type: @ptot_jinzai_bank.employment_type, holiday_vacation: @ptot_jinzai_bank.holiday_vacation, institution_type: @ptot_jinzai_bank.institution_type, job_category: @ptot_jinzai_bank.job_category, job_detail: @ptot_jinzai_bank.job_detail, job_feature: @ptot_jinzai_bank.job_feature, nearest_station: @ptot_jinzai_bank.nearest_station, office_name: @ptot_jinzai_bank.office_name, page_url: @ptot_jinzai_bank.page_url, prefecture: @ptot_jinzai_bank.prefecture, recommended_comment: @ptot_jinzai_bank.recommended_comment, salary: @ptot_jinzai_bank.salary, sub_title: @ptot_jinzai_bank.sub_title, title: @ptot_jinzai_bank.title, work_location: @ptot_jinzai_bank.work_location, working_hours: @ptot_jinzai_bank.working_hours, workplace_feature: @ptot_jinzai_bank.workplace_feature }
    end

    assert_redirected_to ptot_jinzai_bank_path(assigns(:ptot_jinzai_bank))
  end

  test "should show ptot_jinzai_bank" do
    get :show, id: @ptot_jinzai_bank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ptot_jinzai_bank
    assert_response :success
  end

  test "should update ptot_jinzai_bank" do
    patch :update, id: @ptot_jinzai_bank, ptot_jinzai_bank: { corporate_name: @ptot_jinzai_bank.corporate_name, employment_type: @ptot_jinzai_bank.employment_type, holiday_vacation: @ptot_jinzai_bank.holiday_vacation, institution_type: @ptot_jinzai_bank.institution_type, job_category: @ptot_jinzai_bank.job_category, job_detail: @ptot_jinzai_bank.job_detail, job_feature: @ptot_jinzai_bank.job_feature, nearest_station: @ptot_jinzai_bank.nearest_station, office_name: @ptot_jinzai_bank.office_name, page_url: @ptot_jinzai_bank.page_url, prefecture: @ptot_jinzai_bank.prefecture, recommended_comment: @ptot_jinzai_bank.recommended_comment, salary: @ptot_jinzai_bank.salary, sub_title: @ptot_jinzai_bank.sub_title, title: @ptot_jinzai_bank.title, work_location: @ptot_jinzai_bank.work_location, working_hours: @ptot_jinzai_bank.working_hours, workplace_feature: @ptot_jinzai_bank.workplace_feature }
    assert_redirected_to ptot_jinzai_bank_path(assigns(:ptot_jinzai_bank))
  end

  test "should destroy ptot_jinzai_bank" do
    assert_difference('PtotJinzaiBank.count', -1) do
      delete :destroy, id: @ptot_jinzai_bank
    end

    assert_redirected_to ptot_jinzai_banks_path
  end
end

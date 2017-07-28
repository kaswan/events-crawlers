require 'test_helper'

class StJinzaiBanksControllerTest < ActionController::TestCase
  setup do
    @st_jinzai_bank = st_jinzai_banks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:st_jinzai_banks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create st_jinzai_bank" do
    assert_difference('StJinzaiBank.count') do
      post :create, st_jinzai_bank: { corporate_name: @st_jinzai_bank.corporate_name, employment_type: @st_jinzai_bank.employment_type, holiday_vacation: @st_jinzai_bank.holiday_vacation, institution_type: @st_jinzai_bank.institution_type, job_category: @st_jinzai_bank.job_category, job_detail: @st_jinzai_bank.job_detail, job_feature: @st_jinzai_bank.job_feature, nearest_station: @st_jinzai_bank.nearest_station, office_name: @st_jinzai_bank.office_name, page_url: @st_jinzai_bank.page_url, postalcode: @st_jinzai_bank.postalcode, prefecture: @st_jinzai_bank.prefecture, recommended_comment: @st_jinzai_bank.recommended_comment, salary: @st_jinzai_bank.salary, sub_title: @st_jinzai_bank.sub_title, title: @st_jinzai_bank.title, work_location: @st_jinzai_bank.work_location, working_hours: @st_jinzai_bank.working_hours, workplace_feature: @st_jinzai_bank.workplace_feature }
    end

    assert_redirected_to st_jinzai_bank_path(assigns(:st_jinzai_bank))
  end

  test "should show st_jinzai_bank" do
    get :show, id: @st_jinzai_bank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @st_jinzai_bank
    assert_response :success
  end

  test "should update st_jinzai_bank" do
    patch :update, id: @st_jinzai_bank, st_jinzai_bank: { corporate_name: @st_jinzai_bank.corporate_name, employment_type: @st_jinzai_bank.employment_type, holiday_vacation: @st_jinzai_bank.holiday_vacation, institution_type: @st_jinzai_bank.institution_type, job_category: @st_jinzai_bank.job_category, job_detail: @st_jinzai_bank.job_detail, job_feature: @st_jinzai_bank.job_feature, nearest_station: @st_jinzai_bank.nearest_station, office_name: @st_jinzai_bank.office_name, page_url: @st_jinzai_bank.page_url, postalcode: @st_jinzai_bank.postalcode, prefecture: @st_jinzai_bank.prefecture, recommended_comment: @st_jinzai_bank.recommended_comment, salary: @st_jinzai_bank.salary, sub_title: @st_jinzai_bank.sub_title, title: @st_jinzai_bank.title, work_location: @st_jinzai_bank.work_location, working_hours: @st_jinzai_bank.working_hours, workplace_feature: @st_jinzai_bank.workplace_feature }
    assert_redirected_to st_jinzai_bank_path(assigns(:st_jinzai_bank))
  end

  test "should destroy st_jinzai_bank" do
    assert_difference('StJinzaiBank.count', -1) do
      delete :destroy, id: @st_jinzai_bank
    end

    assert_redirected_to st_jinzai_banks_path
  end
end

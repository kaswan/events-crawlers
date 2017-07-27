class PtotJinzaiBank < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }
  def self.csv_head
    [
      human_attribute_name(:id),
      human_attribute_name(:page_url),
      human_attribute_name(:title),
      human_attribute_name(:sub_title),
      human_attribute_name(:job_feature),
      human_attribute_name(:salary),
      human_attribute_name(:working_hours),
      human_attribute_name(:holiday_vacation),
      human_attribute_name(:job_category),
      human_attribute_name(:employment_type),
      human_attribute_name(:job_detail),
      human_attribute_name(:recommended_comment),
      human_attribute_name(:workplace_feature),
      human_attribute_name(:corporate_name),
      human_attribute_name(:office_name),
      human_attribute_name(:institution_type),
      human_attribute_name(:work_location),
      human_attribute_name(:postalcode),
      human_attribute_name(:prefecture),
      human_attribute_name(:nearest_station)
    ].flatten
  end

  def csv_data
    [
      self.id,
      self.page_url,
      self.title,
      self.sub_title,
      self.job_feature,
      self.salary,
      self.working_hours,
      self.holiday_vacation,
      self.job_category,
      self.employment_type,
      self.job_detail,
      self.recommended_comment,
      self.workplace_feature,
      self.corporate_name,
      self.office_name,
      self.institution_type,
      self.work_location,
      self.postalcode,
      self.prefecture,
      self.nearest_station
    ].flatten
  end
end

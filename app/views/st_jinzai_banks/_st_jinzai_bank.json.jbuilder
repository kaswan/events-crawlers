json.extract! st_jinzai_bank, :id, :page_url, :title, :sub_title, :job_feature, :salary, :working_hours, :holiday_vacation, :job_category, :employment_type, :job_detail, :recommended_comment, :workplace_feature, :corporate_name, :office_name, :institution_type, :work_location, :postalcode, :prefecture, :nearest_station, :created_at, :updated_at
json.url st_jinzai_bank_url(st_jinzai_bank, format: :json)
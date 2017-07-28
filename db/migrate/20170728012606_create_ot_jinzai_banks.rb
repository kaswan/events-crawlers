class CreateOtJinzaiBanks < ActiveRecord::Migration
  def change
    create_table :ot_jinzai_banks do |t|
      t.string :page_url
      t.string :title
      t.string :sub_title
      t.text :job_feature
      t.text :salary
      t.string :working_hours
      t.text :holiday_vacation
      t.text :job_category
      t.text :employment_type
      t.text :job_detail
      t.text :recommended_comment
      t.text :workplace_feature
      t.string :corporate_name
      t.string :office_name
      t.string :institution_type      
      t.string :postalcode
      t.string :prefecture
      t.text :work_location
      t.text :nearest_station

      t.timestamps null: false
    end
  end
end

class CreateOtokonJapans < ActiveRecord::Migration
  def change
    create_table :otokon_japans do |t|
      t.string :event_url
      t.string :main_image_url
      t.string :venue_name
      t.string :nearest_station
      t.string :postalcode
      t.string :prefecture_name
      t.string :address
      t.datetime :event_date_time
      t.string :event_start_time
      t.string :event_end_time
      t.string :reception_time
      t.string :title
      t.text :description
      t.string :target_people
      t.string :reservation_limit_for_male
      t.string :reservation_limit_for_female
      t.string :reservation_state_for_male
      t.string :reservation_state_for_female
      t.string :price_for_male
      t.string :price_for_female
      t.string :eligibility_for_all
      t.string :eligibility_for_male
      t.string :eligibility_for_female
      t.string :age_range_for_male
      t.string :age_range_for_female
      t.text :important_reminder
      t.text :cancellation_policy
      t.text :all_images_link
      t.timestamps null: false
    end
  end
end

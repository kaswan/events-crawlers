class CreateExeoJapans < ActiveRecord::Migration
  def change
    create_table :exeo_japans do |t|
      t.string :event_url
      t.string :main_image_url
      t.string :venue_name
      t.string :postalcode
      t.string :prefecture_name
      t.string :address
      t.datetime :event_date_time
      t.string :title
      t.text :description
      t.string :reservation_state_for_male
      t.string :reservation_state_for_female
      t.string :price_for_male
      t.string :price_for_female
      t.string :eligibility_for_male
      t.string :eligibility_for_female
      t.string :age_range_for_male
      t.string :age_range_for_female
      t.string :important_reminder
      t.text :all_images_link

      t.timestamps null: false
    end
  end
end

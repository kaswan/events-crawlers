class ExeoJapan < ActiveRecord::Base
  
  def create_post
   post = Post.new
   post.post_title = self.title
   post.post_content = self.description
   post.guid = "http://happy-ending.net/wp/?p=#{self.id}"
   post = post.save
   post.post_metas.build(:meta_key => 'ev_id', :meta_value => self.id)
   post.post_metas.build(:meta_key => 'event_img_url', :meta_value => self.main_image_url)
   post.post_metas.build(:meta_key => 'event_space', :meta_value => self.venue_name)
   post.post_metas.build(:meta_key => 'event_address', :meta_value => self.prefecture_name + self.address)
   post.post_metas.build(:meta_key => 'event_date', :meta_value => self.event_date_time.to_date)
   post.post_metas.build(:meta_key => 'event_date_start', :meta_value => self.event_date_time.to_s(:time))
   post.post_metas.build(:meta_key => 'title', :meta_value => self.title)
   post.post_metas.build(:meta_key => 'event_pr', :meta_value => self.description)
   post.post_metas.build(:meta_key => 'reserve_male', :meta_value => self.reservation_state_for_male)
   post.post_metas.build(:meta_key => 'reserve_female', :meta_value => self.reservation_state_for_female)
   post.post_metas.build(:meta_key => 'event_price_male', :meta_value => self.price_for_male)
   post.post_metas.build(:meta_key => 'event_price_female', :meta_value => self.price_for_female)
   post.post_metas.build(:meta_key => 'event_app_conditions_male', :meta_value => self.eligibility_for_male)
   post.post_metas.build(:meta_key => 'event_app_conditions_female', :meta_value => self.eligibility_for_female)
   post.post_metas.build(:meta_key => 'event_target_age_male', :meta_value => self.age_range_for_male)
   post.post_metas.build(:meta_key => 'event_target_age_female', :meta_value => self.age_range_for_female)
   post.post_metas.build(:meta_key => 'ev_note', :meta_value => self.important_reminder)
  end
  
  def self.csv_head
    [
      human_attribute_name(:id),
      human_attribute_name(:event_url),
      human_attribute_name(:title),
      human_attribute_name(:description),
      human_attribute_name(:event_date_time),
      human_attribute_name(:venue_name),
      human_attribute_name(:postalcode),
      human_attribute_name(:prefecture_name),
      human_attribute_name(:address),
      human_attribute_name(:reservation_state_for_male),
      human_attribute_name(:reservation_state_for_female),
      human_attribute_name(:price_for_male),
      human_attribute_name(:price_for_female),
      human_attribute_name(:eligibility_for_male),
      human_attribute_name(:eligibility_for_female),
      human_attribute_name(:age_range_for_male),
      human_attribute_name(:age_range_for_female),
      human_attribute_name(:important_reminder),
      human_attribute_name(:main_image_url),
      human_attribute_name(:all_images_link)
    ].flatten
  end

  def csv_data
    [
     self.id,
      self.event_url,
      self.title,
      self.description,
      self.event_date_time,
      self.venue_name,
      self.postalcode,
      self.prefecture_name,
      self.address,
      self.reservation_state_for_male,
      self.reservation_state_for_female,
      self.price_for_male,
      self.price_for_female,
      self.eligibility_for_male,
      self.eligibility_for_female,
      self.age_range_for_male,
      self.age_range_for_female,
      self.important_reminder,
      self.main_image_url,
      self.all_images_link
    ].flatten
  end
end

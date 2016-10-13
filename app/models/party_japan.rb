class PartyJapan < ActiveRecord::Base
  has_one :post, as: :parent
  default_scope { order(updated_at: :desc) }
    
  def self.create_post
    PartyJapan.all.each  do |e|
      params = {}
      params[:post] = {:post_title => e.title, :post_content => '<a href="https://track.affiliate-b.com/visit.php?guid=ON&a=W3279W-y639553&p=t4956890" target="_blank" rel="nofollow">毎週開催の★人気婚活パーティーなら！</a><img src="https://track.affiliate-b.com/lead/W3279W/t4956890/y639553" width="1" height="1" style="border:none;"/>', :guid => ""}
      if e.post
        post = e.post
      else
        post = e.build_post(params[:post])
      end
      post.post_metas.destroy_all unless post.post_metas.blank?
      post.post_metas.build(:meta_key => 'ev_id', :meta_value => e.id)
      post.post_metas.build(:meta_key => 'event_img_url', :meta_value => e.main_image_url)
      post.post_metas.build(:meta_key => 'event_space', :meta_value => e.venue_name)
      post.post_metas.build(:meta_key => 'station', :meta_value => e.nearest_station)
      post.post_metas.build(:meta_key => 'event_address', :meta_value => e.prefecture_name + e.address)
      post.post_metas.build(:meta_key => 'event_date', :meta_value => e.event_date_time.to_date)
      post.post_metas.build(:meta_key => 'event_date_start', :meta_value => e.event_date_time.to_s(:time))
      post.post_metas.build(:meta_key => 'title', :meta_value => e.title)
      post.post_metas.build(:meta_key => 'event_pr', :meta_value => e.description)
      post.post_metas.build(:meta_key => 'reserve_male', :meta_value => e.reservation_state_for_male)
      post.post_metas.build(:meta_key => 'reserve_female', :meta_value => e.reservation_state_for_female)
      post.post_metas.build(:meta_key => 'event_price_male', :meta_value => e.price_for_male)
      post.post_metas.build(:meta_key => 'event_price_female', :meta_value => e.price_for_female)
      post.post_metas.build(:meta_key => 'event_app_conditions_male', :meta_value => e.eligibility_for_male)
      post.post_metas.build(:meta_key => 'event_app_conditions_female', :meta_value => e.eligibility_for_female)
      post.post_metas.build(:meta_key => 'event_target_age_male', :meta_value => e.age_range_for_male)
      post.post_metas.build(:meta_key => 'event_target_age_female', :meta_value => e.age_range_for_female)
      post.post_metas.build(:meta_key => 'ev_note', :meta_value => e.important_reminder)
      post.post_metas.build(:meta_key => 'event_host', :meta_value => '777')
      post.post_metas.build(:meta_key => '_event_host', :meta_value => 'field_57bfc186741fc')
      post.post_metas.build(:meta_key => 'event_link', :meta_value => e.event_url)
      post.post_metas.build(:meta_key => 'event_cancel', :meta_value => e.cancellation_deadline)
      post.post_metas.build(:meta_key => 'mochimono', :meta_value => e.personal_document)
      post.post_metas.build(:meta_key => 'food', :meta_value => e.food_drink)
      post.post_metas.build(:meta_key => 'fukuso', :meta_value => e.event_dress_code)
      post.post_metas.build(:meta_key => 'sugo', :meta_value => e.gathering_place)
      if post.term_relations.blank?
        post.term_relations.build(:term_taxonomy_id => '6', :term_order => '0')
        post.term_relations.build(:term_taxonomy_id => '7', :term_order => '0')
        prefecture = e.prefecture_name.gsub(/['県','府']/,'').gsub('東京都','東京')
        term = Term.find_by_name(prefecture)
        post.term_relations.build(:term_taxonomy_id => term.term_id, :term_order => '0') unless term.blank?
      end
      post.save!  
    end
  end
  
  def self.csv_head
    [
      human_attribute_name(:id),
      human_attribute_name(:event_url),
      human_attribute_name(:title),
      human_attribute_name(:description),
      human_attribute_name(:event_date_time),
      human_attribute_name(:venue_name),
      human_attribute_name(:nearest_station),
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
      human_attribute_name(:personal_document),
      human_attribute_name(:food_drink),
      human_attribute_name(:event_dress_code),
      human_attribute_name(:cancellation_deadline),
      human_attribute_name(:contact_info),
      human_attribute_name(:gathering_place),
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
      self.nearest_station,
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
      self.personal_document,
      self.food_drink,
      self.event_dress_code,
      self.cancellation_deadline,
      self.contact_info,
      self.gathering_place,
      self.important_reminder,
      self.main_image_url,
      self.all_images_link
    ].flatten
  end
end

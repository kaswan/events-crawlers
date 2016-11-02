class OtokonJapan < ActiveRecord::Base
  has_one :post, as: :parent
  default_scope { order(updated_at: :desc) }
    
  after_create :create_or_update_post
  after_update :create_or_update_post
  
  def self.create_post
    OtokonJapan.all.each  do |e|
       e.create_or_update_post
    end
  end
  
  def create_or_update_post
    params = {}
    params[:post] = {:post_title => self.title, :post_content => self.event_url, :guid => ""}
    if self.post
      post = self.post
    else
      post = self.build_post(params[:post])
    end
    post.post_metas.destroy_all unless post.post_metas.blank?
    post.post_metas.build(:meta_key => 'ev_id', :meta_value => self.id)
    post.post_metas.build(:meta_key => 'event_img_url', :meta_value => self.main_image_url)
    post.post_metas.build(:meta_key => 'event_space', :meta_value => self.venue_name)
    post.post_metas.build(:meta_key => 'station', :meta_value => self.nearest_station)
    post.post_metas.build(:meta_key => 'event_address', :meta_value => self.prefecture_name + self.address)
    post.post_metas.build(:meta_key => 'event_date', :meta_value => self.event_date_time.to_date)
    post.post_metas.build(:meta_key => 'event_date_start', :meta_value => self.event_start_time) #self.event_date_time.to_s(:time))
    post.post_metas.build(:meta_key => 'event_date_end', :meta_value => self.event_end_time) 
    post.post_metas.build(:meta_key => 'reception', :meta_value => self.reception_time)
    post.post_metas.build(:meta_key => 'title', :meta_value => self.title)
    post.post_metas.build(:meta_key => 'event_pr', :meta_value => self.description)
    
    post.post_metas.build(:meta_key => 'number_male', :meta_value => self.reservation_limit_for_male)
    post.post_metas.build(:meta_key => 'number_female', :meta_value => self.reservation_limit_for_female)
    
    post.post_metas.build(:meta_key => 'reserve_male', :meta_value => self.reservation_state_for_male)
    post.post_metas.build(:meta_key => 'reserve_female', :meta_value => self.reservation_state_for_female)
    post.post_metas.build(:meta_key => 'event_price_male', :meta_value => self.price_for_male)
    post.post_metas.build(:meta_key => 'event_price_female', :meta_value => self.price_for_female)
    post.post_metas.build(:meta_key => 'event_app_conditions', :meta_value => self.eligibility_for_all)
    post.post_metas.build(:meta_key => 'event_app_conditions_male', :meta_value => self.eligibility_for_male)
    post.post_metas.build(:meta_key => 'event_app_conditions_female', :meta_value => self.eligibility_for_female)
    post.post_metas.build(:meta_key => 'event_target_age_male', :meta_value => self.age_range_for_male)
    post.post_metas.build(:meta_key => 'event_target_age_female', :meta_value => self.age_range_for_female)
    post.post_metas.build(:meta_key => 'ev_note', :meta_value => self.important_reminder)
    post.post_metas.build(:meta_key => 'event_cancel', :meta_value => self.cancellation_policy)
    
    post.post_metas.build(:meta_key => 'event_host', :meta_value => '507')
    post.post_metas.build(:meta_key => '_event_host', :meta_value => 'field_57bfc186741fc')
    post.post_metas.build(:meta_key => 'event_link', :meta_value => self.event_url)
    
    post.term_relations.destroy_all unless post.term_relations.nil?
    #if post.term_relations.blank?
    post.term_relations.build(:term_taxonomy_id => '6', :term_order => '0')
    post.term_relations.build(:term_taxonomy_id => '7', :term_order => '0')
    prefecture = self.prefecture_name.gsub(/['県','府']/,'').gsub('東京都','東京')
    term = Term.find_by_name(prefecture)
    post.term_relations.build(:term_taxonomy_id => term.term_id, :term_order => '0') unless term.blank?
    # For male
    age_range_for_male = self.age_range_for_male.gsub(/['歳位']/,'').split(/['〜']/)
    age_range = []
    age_range_for_male.each do |age|
      age_range << age_range_term_for_male(age)
    end unless age_range_for_male.blank?
    age_range.uniq.each do |age|
      post.term_relations.build(:term_taxonomy_id => age, :term_order => '0')
    end
    # For female
    age_range_for_female = self.age_range_for_female.gsub(/['歳位']/,'').split(/['〜']/)
    age_range = []
    age_range_for_female.each do |age|
      age_range << age_range_term_for_female(age)
    end unless age_range_for_female.blank?
    age_range.uniq.each do |age|
      post.term_relations.build(:term_taxonomy_id => age, :term_order => '0')
    end
    
    #end
    post.save! 
  end
  
  def age_range_term_for_male age
      
    unless age.blank? && age.to_i > 0
      case age.to_i
      when 20..29
        return 61
      when 30..39
        return 62
      when 40..49
        return 63
      when 50..59
        return 64
      when 60..75
        return 65
      else
        return false
      end
    end
    return false
  end
  
  
  def age_range_term_for_female age
      
    unless age.blank? && age.to_i > 0
      case age.to_i
      when 20..29
        return 66
      when 30..39
        return 67
      when 40..49
        return 68
      when 50..59
        return 69
      when 60..75
        return 70
      else
        return false
      end
    end
    return false
  end
  
  def self.csv_head
    [
      human_attribute_name(:id),
      human_attribute_name(:event_url),
      human_attribute_name(:title),
      human_attribute_name(:description),
      human_attribute_name(:target_people),
      human_attribute_name(:event_date_time),
      human_attribute_name(:event_start_time),
      human_attribute_name(:event_end_time),
      human_attribute_name(:reception_time),
      human_attribute_name(:venue_name),
      human_attribute_name(:nearest_station),
      human_attribute_name(:postalcode),
      human_attribute_name(:prefecture_name),
      human_attribute_name(:address),
      human_attribute_name(:access),
      human_attribute_name(:reservation_limit_for_male),
      human_attribute_name(:reservation_limit_for_female),
      human_attribute_name(:reservation_state_for_male),
      human_attribute_name(:reservation_state_for_female),
      human_attribute_name(:price_for_male),
      human_attribute_name(:price_for_female),      
      human_attribute_name(:eligibility_for_all),
      human_attribute_name(:eligibility_for_male),
      human_attribute_name(:eligibility_for_female),
      human_attribute_name(:age_range_for_male),
      human_attribute_name(:age_range_for_female),
      human_attribute_name(:important_reminder),
      human_attribute_name(:cancellation_policy),      
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
      self.target_people,
      self.event_date_time,
      self.event_start_time,
      self.event_end_time,
      self.reception_time,
      self.venue_name,
      self.nearest_station,
      self.postalcode,
      self.prefecture_name,
      self.address,
      self.access,
      self.reservation_limit_for_male,
      self.reservation_limit_for_female,
      self.reservation_state_for_male,
      self.reservation_state_for_female,
      self.price_for_male,
      self.price_for_female,
      self.eligibility_for_all,
      self.eligibility_for_male,
      self.eligibility_for_female,
      self.age_range_for_male,
      self.age_range_for_female,
      self.important_reminder,
      self.cancellation_policy,
      self.main_image_url,
      self.all_images_link
    ].flatten
  end
end

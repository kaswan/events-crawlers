# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'
web_site_url = "http://www.exeo-japan.co.jp"
page = agent.get("http://www.exeo-japan.co.jp/ex_schedule/")

form =  page.form_with(:name => 'searchMore')

form.checkboxes_with(:name => /area/).each{|sub_area| sub_area.check}
form.checkboxes_with(:name => /plan/).each{|plan| plan.check if [1,2,3,4,5,41].include?(plan.value.to_i)}
  
result =  form.submit(form.button_with(:class => /orange/))
event_detail_pages = []
result.search('//div[@class="pv-contents"]//a').select{|link| link[:href] && link[:href].match(/ex_schedule/)}.each do |link|
  event_detail_pages << link[:href]
end
next_page = result.search('//span[@class="page-controler"]//a').select{|link| link && link[:href] && link[:class] == 'next'} 
unless next_page.blank?
  next_page = next_page.first[:href] 
  begin  
      
    p "#####################################################"
    p result.search('//span[@class="pages"]').inner_text
    p "#####################################################"
      
    result = result.link_with(:href => next_page).click
    result.search('//div[@class="pv-contents"]//a').select{|link| link[:href] && link[:href].match(/ex_schedule/)}.each do |link|
      event_detail_pages << link[:href]
    end   
    next_page = result.search('//span[@class="page-controler"]//a').select{|link| link && link[:href] && link[:class] == 'next'} 
    next_page = next_page.first[:href] unless next_page.blank?
       
  end while !next_page.blank?
end
p event_detail_pages.uniq.count
  
event_detail_pages.uniq.each do |detail_page_link|
  detail_page = agent.get(detail_page_link)
  event_id = detail_page_link.gsub('/ex_schedule/reserve.php?seq=','')
  event_url = web_site_url + detail_page_link
  #venue images
  all_images_link = []
  detail_page.search('//figure[@class="root_map"]//img').each do |image|
    all_images_link << image[:src]
  end 
  #Top image
  main_image_url = nil
  detail_page.search('//div[@class="item"]//img').each do |image|
    main_image_url = image[:src]
  end    
  venue = detail_page.search('//div[@class="in"]//span')
  venue_name = venue.first.inner_text.strip
  postalcode = venue.at('//span[@itemprop="postalCode"]').inner_text.strip
  prefecture_name = venue.at('//span[@itemprop="addressRegion"]').inner_text.strip
  address1 = venue.at('//span[@itemprop="addressLocality"]').inner_text.strip
  address2 = venue.at('//span[@itemprop="streetAddress"]').inner_text.strip
  address = address1 + address2
  item_info = detail_page.search('//div[@class="item-info-in"]//div')    
  event_date_time = item_info.children.search('//div[@class="item-date"]/@content').to_s
  event_date_time = DateTime.parse(event_date_time)
  p event_date_time
  title = item_info.children.search('//div[@class="item-title"]').inner_text.strip
  description = detail_page.search('//div[@itemprop="description"]/p').inner_text.strip #.gsub(/w+/,'').gsub(/['\n','\r']/,'')
  
  conditions = {}
  detail_page.search('//div[@class="item-info-body alfa"]/dl').each do |cond|
    cond.search('dt').each_with_index do |plan, i|
      ((conditions[i]||={})['type']||=[]) << plan.inner_text.strip
    end
    cond.search('dd').each_with_index do |div, i|
      div.search('div[@class="condition"]').each do |plan|
        ((conditions[i]||={})['male']||=[]) << plan.search('div[@class="male"]').inner_text.strip unless plan.search('div[@class="male"]').blank?         
        ((conditions[i]||={})['female']||=[]) << plan.search('div[@class="female"]').inner_text.strip unless plan.search('div[@class="female"]').blank? 
      end
    end    
  end
  p conditions
  qualifications = {}
  detail_page.search('//div[@itemprop="description"]/dl').each do |cond|
    cond.search('dt').each_with_index do |plan, i|
      ((qualifications[i]||={})['type']||=[]) << plan.inner_text.strip        
    end
    cond.search('ul').each_with_index do |plan, i|
      ((qualifications[i]||={})['male']||=[]) << plan.search('li[@class="male"]').inner_text.strip unless plan.search('li[@class="male"]').blank?
      ((qualifications[i]||={})['female']||=[]) << plan.search('li[@class="female"]').inner_text.strip unless plan.search('li[@class="female"]').blank? 
    end  
    
    cond.search('dd').each_with_index do |plan, i|
      if plan.search('ul').blank?
        ((qualifications[i]||={})['other']||=[]) << plan.inner_text.strip
      end
    end
  end

  begin  
    ExeoJapan.transaction do  
      ExeoJapan.where(id: event_id).first_or_initialize.tap do |exeo| 
        exeo.id = event_id
        exeo.event_url = event_url
        exeo.main_image_url = main_image_url
        exeo.all_images_link = all_images_link.join(',')
        exeo.venue_name = venue_name
        exeo.postalcode = postalcode.gsub('〒','')
        exeo.prefecture_name = prefecture_name
        exeo.address = address 
        exeo.event_date_time = event_date_time
        exeo.title = title
        exeo.description = description
        conditions.values.each do |condition|
          if condition['type'].join == "予約状況"
            exeo.reservation_state_for_male = condition['male'].join if condition['male']
            exeo.reservation_state_for_female = condition['female'].join if condition['female']
          elsif condition['type'].join == "料　　金"
            exeo.price_for_male = condition['male'].join if condition['male']
            exeo.price_for_female = condition['female'].join if condition['female']
          end
        end
        
        qualifications.values.each do |qualification|
          if qualification['type'].join == "参加資格"
            exeo.eligibility_for_male = qualification['male'].join if qualification['male']
            exeo.eligibility_for_female = qualification['female'].join if qualification['female']
          elsif qualification['type'].join == "対象年齢"
            exeo.age_range_for_male = qualification['male'].join if qualification['male']
            exeo.age_range_for_female = qualification['female'].join if qualification['female']          
          elsif qualification['type'].join == "注意事項"
            exeo.important_reminder = qualification['other'].join if qualification['other']
          end
        end
        exeo.save
      end
    end
  rescue Exception => e
    p e.backtrace.join("\n")    
  end    
  #exit
end

#ExeoJapan.create_post
# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'
web_site_url = "http://www.otocon.jp"
#page = agent.get("http://www.otocon.jp/search/?/m=50/w=50/")
page = agent.get("http://www.otocon.jp/search/")
event_detail_pages = []
page.search('//ul//h3//a').select{|link| link[:href] && link[:href].match(/detail.html/)}.each do |link|
  event_detail_pages << link[:href]
end
next_page = page.search('//p[@class="pager"]//span//a').select{|link| link[:href] && link.inner_text == "次の10件>" }
unless next_page.blank?
  next_page = next_page.first[:href] 
  begin
    p "#####################################################"
    p next_page
    p "#####################################################"
    page = page.link_with(:href => next_page).click
    page.search('//ul//h3//a').select{|link| link[:href] && link[:href].match(/detail.html/)}.each do |link|
      event_detail_pages << link[:href]
    end
    next_page = page.search('//p[@class="pager"]//span//a').select{|link| link[:href] && link.inner_text == "次の10件>" }
    next_page = next_page.first[:href] unless next_page.blank?
  end while !next_page.blank?
end
p event_detail_pages.size
#event_detail_pages << "/party/detail.html$/party_id/10582/"
event_detail_pages.uniq.each do |detail_page_link|
  p detail_page_link
  event_id = detail_page_link.gsub('/party/detail.html$/party_id/','').gsub('/','')
  event_url = web_site_url + detail_page_link
  detail_page = agent.get(detail_page_link)
  title = detail_page.search('//div[@id="party-body-hed"]//h3').inner_text.strip
  description = ""
  important_reminder = ""
  cancellation_policy = ""
  detail_page.search('//div[@class="text-cont"]').each do |dtext|
    description = dtext.search('div').inner_text.strip if dtext.search('img/@alt').to_s.strip == "パーティー内容"
    important_reminder = dtext.search('div').inner_text.strip if dtext.search('img/@alt').to_s.strip == "注意事項"
    cancellation_policy = dtext.search('div').inner_text.strip if dtext.search('img/@alt').to_s.strip == "キャンセル料について"
  end

  address = ""
  prefecture_name = ""
  access = ""
  detail_page.search('//div[@class="cont-wrap"]/dl').each do |cont|
    address = cont.search('//dd').first.inner_text.strip
    unless address.nil?
      if address.split(/['県']/).size > 1
        prefecture_name = address.split(/['県']/).first
      elsif address.split(/['府']/).size > 1
        prefecture_name = address.split(/['府']/).first
      elsif address.split(/['都']/).size > 1
        prefecture_name = address.split(/['都']/).first
      elsif address.split(/['区']/).size > 1 && ["千代田","中央","港","新宿","文京","台東","墨田","江東","品川","目黒","大田","世田谷","渋谷","中野","杉並","豊島","北","荒川","板橋","練馬","足立","葛飾","江戸川"].include?(address.split(/['区']/).first.strip)
        prefecture_name = "東京"
      elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "名古屋"
        prefecture_name = "愛知"
      elsif address.split('海道').size > 1 && address.split('海道').first.strip == "北"
        prefecture_name = "北海道"
      elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "札幌"
              prefecture_name = "北海道"  
      end
    end  
    access = cont.search('//dd').last.inner_text.strip
  end
  
  target_people = detail_page.search('//div[@id="party-body-hed"]//h4').inner_text.strip
  main_image_url = web_site_url + detail_page.search('//div[@id="party-body"]//p[@class="p_image"]/img/@src').to_s
  
  reservation_state_for_male = detail_page.search('//div[@id="party-body-hed"]//table[@class="table-ojt_twin"]//td').first.search('img/@alt').to_s
  reservation_state_for_female = detail_page.search('//div[@id="party-body-hed"]//table[@class="table-ojt_twin"]//td').last.search('img/@alt').to_s
  
  event_date_time_detail = detail_page.search('//div[@class="partyList-date"]//table').at('tr').search('td').inner_text.strip.gsub(/['\n']/,'').split(/['（','）']/)
  event_date = Date.parse(event_date_time_detail.first.gsub(/['年','月','日']/,'-'))
  event_date_time_detail
  
  event_start_time =  event_date_time_detail[2].split('〜').first
  event_date_time = DateTime.parse("#{event_date} #{event_start_time} +900")
  event_end_time =  event_date_time_detail[2].split('〜').last
  reception_time = event_date_time_detail[3].gsub('受付時間：','')
    
  event_conditions = {}
  detail_page.search('//div[@id="party-body"]//div[@class="partyList-table"]/table').last.search('tr').each do |tr|
    field = tr.at('th/img/@alt').to_s
    tr.at('td/table').search('tr').each do |ctr|
      p field
      if field == "場所"
        venue = ctr.inner_text.gsub("〜\n",'〜').split(/['\n\n\n' '\n\n' '\n']/).compact.reject(&:blank?)
        event_conditions['venue_name'] = venue.first
        event_conditions['nearest_station'] = venue.last
      end
      if field == "年齢"
       age_limit = ctr.inner_text.gsub("〜\n",'〜').split(/['\n\n\n' '\n\n' '\n']/).compact.reject(&:blank?)
       event_conditions['age_range_for_male'] = age_limit[1] if age_limit[1]
       event_conditions['age_range_for_female'] = age_limit[3] if age_limit[3]
      end
      if field == "金額"
        price = ctr.inner_text.gsub("〜\n",'〜').split(/['\n\n\n' '\n\n' '\n']/).compact.reject(&:blank?)
        event_conditions['price_for_male'] = price[1].gsub('&nbsp', ' ') if price[1]
        event_conditions['price_for_female'] = price[3].gsub('&nbsp', ' ') if price[3]
      end
      if  field == "人数"
        limit = ctr.inner_text.gsub("〜\n",'〜').split(/['\n\n\n' '\n\n' '\n']/).compact.reject(&:blank?)
        event_conditions['reservation_limit_for_male'] = limit[1]
        event_conditions['reservation_limit_for_female'] = limit[3]
      end
      if field == "条件"
        cond = ctr.inner_text.gsub("〜\n",'〜').split(/['\n\n\n' '\n\n' '\n']/).compact.reject(&:blank?)
        event_conditions['eligibility_for_all'] = cond[1] if cond[0] == "共通"
        event_conditions['eligibility_for_male'] = cond[1] if cond[0] == "男性"
        event_conditions['eligibility_for_female'] = cond[1] if cond[0] == "女性"
      end
      p ctr.inner_text.gsub("〜\n",'〜').split(/['\n\n\n' '\n\n' '\n']/).compact.reject(&:blank?)
    end unless tr.at('td/table').nil?
  end
  
  begin  
    OtokonJapan.transaction do  
      OtokonJapan.where(id: event_id).first_or_initialize.tap do |otokon| 
        otokon.id = event_id
        otokon.event_url = event_url
        otokon.main_image_url = main_image_url
        otokon.prefecture_name = prefecture_name
        otokon.address = address
        otokon.access = access
        otokon.title = title
        otokon.description = description
        otokon.important_reminder = important_reminder
        otokon.cancellation_policy = cancellation_policy
        otokon.event_date_time = event_date_time
        otokon.event_start_time = event_start_time
        otokon.event_end_time = event_end_time
        otokon.reception_time = reception_time
        otokon.target_people = target_people
        otokon.reservation_state_for_male = reservation_state_for_male
        otokon.reservation_state_for_female = reservation_state_for_female
        #conditions
        
        otokon.venue_name = event_conditions['venue_name'] if event_conditions['venue_name']
        otokon.nearest_station = event_conditions['nearest_station'] if event_conditions['nearest_station']
        otokon.price_for_male = event_conditions['price_for_male'] if event_conditions['price_for_male']
        otokon.price_for_female = event_conditions['price_for_female'] if event_conditions['price_for_female']
          
        otokon.age_range_for_male = event_conditions['age_range_for_male'] if event_conditions['age_range_for_male']
        otokon.age_range_for_female = event_conditions['age_range_for_female'] if event_conditions['age_range_for_female']
          
        otokon.eligibility_for_all = event_conditions['eligibility_for_all'] if event_conditions['eligibility_for_all']
        otokon.eligibility_for_male = event_conditions['eligibility_for_male'] if event_conditions['eligibility_for_male']
        otokon.eligibility_for_female = event_conditions['eligibility_for_female'] if event_conditions['eligibility_for_female']
          
        otokon.reservation_limit_for_male = event_conditions['reservation_limit_for_male'] if event_conditions['reservation_limit_for_male']
        otokon.reservation_limit_for_female = event_conditions['reservation_limit_for_female'] if event_conditions['reservation_limit_for_female']
          
        otokon.save  
      end
    end
  rescue Exception => e
    p e.backtrace.join("\n")    
  end
  
  #exit
end

#OtokonJapan.create_post
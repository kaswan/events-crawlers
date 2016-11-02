# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'
web_site_url = "https://www.partyparty.jp"
page = agent.get("https://www.partyparty.jp")

form =  page.form_with(:id => 'partySearchForm')
event_detail_pages = []
#%w(20 25 30 35 40 45 50 55 60 65 70).each do |age|
  #form.field_with(:name => 'mal_age').value = age
  #form.field_with(:name => 'fem_age').value = age.to_i - 10
  result =  form.submit(form.button_with(:name => 'partySearch'))    
  
  result.search('//div[@class="search-section"]//a').select{|link| link[:href] && link[:href].match(/party-detail/)}.each do |link|
    event_detail_pages << link[:href]
  end
  next_page = result.search('//ul[@class="page-nav"]//a').select{|link| link[:href] && link.inner_text == "次へ" }
  unless next_page.blank?
    next_page = next_page.first[:href]   
    begin
      p "#####################################################"
      p next_page
      p "#####################################################"
      result = result.link_with(:href => next_page).click
      result.search('//div[@class="search-section"]//a').select{|link| link[:href] && link[:href].match(/party-detail/)}.each do |link|
        event_detail_pages << link[:href]
      end
      next_page = result.search('//ul[@class="page-nav"]//a').select{|link| link[:href] && link.inner_text == "次へ" }
      next_page = next_page.first[:href] unless next_page.blank?
    end while !next_page.blank?
  end
#end
p event_detail_pages

p event_detail_pages.uniq.count  

#event_detail_pages << "https://www.partyparty.jp/party-detail/pid100581/"

event_detail_pages.uniq.each do |detail_page_link|
  p detail_page_link
  p event_id = detail_page_link.gsub('https://www.partyparty.jp/party-detail/pid','').gsub('/','')
  event_url = detail_page_link
  detail_page = agent.get(detail_page_link)
  detail_page = detail_page.search('//div[@id="main"]')
  main_image_url = web_site_url + detail_page.search('//div[@class="party-detail-box-left"]//p[@class="img"]/img/@src').to_s


  next if detail_page.search('//div[@class="party-detail-top clearfix"]/p').blank?
  date_time = detail_page.search('//div[@class="party-detail-top clearfix"]/p')[1].inner_text.split(/['（'|'）'|'～']/)
  year =  date_time.first.split('/').first.to_i >= Date.today.month ? Date.today.year : (Date.today.year + 1)
  event_date_time = DateTime.parse("#{year}/#{date_time.first} #{date_time.last} +0900")
  title = detail_page.search('//div[@class="party-detail-box-tit"]//p[@class="txt1"]').inner_text.strip
  description = detail_page.search('//div[@class="detail-contents-txt"]').inner_text.strip.gsub('💛','').gsub('📨','').gsub('📩','')

  venue_name = detail_page.search('//div[@class="party-detail-box-place"]//dl').first.search('dt').inner_text.strip.gsub('■','')
  aceess_info = detail_page.search('//div[@class="party-detail-box-place"]//dl').first.search('dd').inner_text.strip
  address, nearest_station, contact_info, gathering_place = nil, nil, nil, nil
  

  if aceess_info.split(/['\r'|'\n'|'\t']/).compact.reject(&:blank?).size <= 3 || !aceess_info.scan('：').blank?   
    aceess_info = aceess_info.split(/['\r'|'\n'|'\t'|'■'|'：']/).compact.reject(&:blank?).in_groups_of(2)
    aceess_info.each do |a|
      if a.first == "住所"
        address = a.last.strip
      elsif a.first == "アクセス"
        nearest_station = a.last
      elsif a.first == "連絡先"
        contact_info = a.last
      elsif a.first == "集合"
        gathering_place = a.last
      end
    end
  else
    aceess_info = aceess_info.split(/['<'|'>'|'\r'|'\n'|'\t'|'《'|'》'|'【'|'】'|'＜'|'＞']/).compact.reject(&:blank?)
    p aceess_info
    if aceess_info.first == "TEL"
      (aceess_info - ["TEL"]).in_groups_of(3).each do |a|
        if a.first == "住所"
          address = a[1].strip + a[2].strip
        elsif a.first == "アクセス"
          nearest_station = a[1].strip + a[2].strip
        elsif a[1] == "当日会場TEL"
          contact_info = a[2]
        end 
      end
    elsif aceess_info.first == "会場" || aceess_info.first == "事務局連絡先"
      if aceess_info.include?('住所')
        aceess_info.in_groups_of(2).each do |a|
          if a.first == "住所"
            address = a[1].strip
          elsif a.first == "アクセス"
            nearest_station = a[1].strip
          elsif a.first == "会場"
            venue_name = a[1].strip unless a[1].blank?          
          end 
        end
      else aceess_info.include?('会場')
        aceess_info.in_groups_of(4).each do |a|
          if a.first == "アクセス"
            nearest_station = a[1].strip
          elsif a.first == "会場"
            address = a[1] + a[2] + a[3]
          end 
        end
      end  
    elsif aceess_info.first == "住所"
      address = aceess_info[1].strip
      address = (address + aceess_info[2]) if aceess_info[2]
      nearest_station = aceess_info[3]
      nearest_station = (nearest_station + aceess_info[4]) if aceess_info[4]
    else
      address = aceess_info[0]
      contact_info = aceess_info[1]
      nearest_station = aceess_info[3].strip
      nearest_station = (nearest_station + aceess_info[4]) if aceess_info[4]
    end  
  end  
  prefecture_name = ""
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
    end
  end
  postalcode = prefecture_name.gsub(/[\D]/, '')
  p prefecture_name = prefecture_name.gsub(/[^\D]/, '').gsub('〒-','').squish
  p "------------------------"
  event_conditions = {}  
  detail_page.search('//div[@class="party-detail-info"]//tr').each do |tr|
    th = tr.search('th').inner_text
    unless tr.search('td[@class="detail-info-price"]').blank?
      conditions = []
      tr.search('ul[@class="condition"]/li').each do |li|
        conditions << li.inner_text.split(/['\r'|'\n'|'\t']/).compact.reject(&:blank?)
      end
      conditions = conditions.flatten.in_groups_of(4)
      conditions.each do |cond|
        if cond.first == "男性"
          event_conditions['price_for_male'] = (cond[1].split("／").size > 1 ? "#{cond[1]}(Web割)" : cond[1].split("⇒").size > 1 ? "#{cond[1]}(早割)" : cond[1]) if cond[1]
          event_conditions['reservation_state_for_male'] = cond[2] if cond[2]
          event_conditions['age_range_for_male'] = cond[3] if cond[3]
        elsif cond.first == "女性"
          event_conditions['price_for_female'] = (cond[1].split("／").size > 1 ? "#{cond[1]}(Web割)" : cond[1].split("⇒").size > 1 ? "#{cond[1]}(早割)" : cond[1]) if cond[1]
          event_conditions['reservation_state_for_female'] = cond[2] if cond[2]
          event_conditions['age_range_for_female'] = cond[3] if cond[3]
        end
      end  
    else
      if th == "持ち物"
        event_conditions['personal_document'] = tr.search('td').inner_text.strip
      elsif th == "Food & Drink"
        event_conditions['food_drink'] = tr.search('td').inner_text.strip
      elsif th == "服装"
        event_conditions['event_dress_code'] = tr.search('td').inner_text.strip
      elsif th == "キャンセル"
        event_conditions['cancellation_deadline'] = tr.search('td').inner_text.strip
      end
    end
  end
  # SAVE TO DB
  begin  
    PartyJapan.transaction do
      PartyJapan.where(id: event_id).first_or_initialize.tap do |party| 
        party.id = event_id
        party.event_url = event_url
        party.main_image_url = main_image_url
        party.prefecture_name = prefecture_name
        party.address = address
        party.contact_info = contact_info
        party.gathering_place = gathering_place
        party.title = title
        party.description = description
        party.event_date_time = event_date_time
    
        #conditions
          
        party.venue_name = venue_name
        party.nearest_station = nearest_station
        party.price_for_male = event_conditions['price_for_male'] if event_conditions['price_for_male']
        party.price_for_female = event_conditions['price_for_female'] if event_conditions['price_for_female']
          
        party.age_range_for_male = event_conditions['age_range_for_male'] if event_conditions['age_range_for_male']
        party.age_range_for_female = event_conditions['age_range_for_female'] if event_conditions['age_range_for_female']
          
        party.eligibility_for_male = event_conditions['eligibility_for_male'] if event_conditions['eligibility_for_male']
        party.eligibility_for_female = event_conditions['eligibility_for_female'] if event_conditions['eligibility_for_female']
            
        party.reservation_state_for_male = event_conditions['reservation_state_for_male'] if event_conditions['reservation_state_for_male']
        party.reservation_state_for_female = event_conditions['reservation_state_for_female'] if event_conditions['reservation_state_for_female']
          
        party.personal_document = event_conditions['personal_document'] if event_conditions['personal_document']
        party.food_drink = event_conditions['food_drink'] if event_conditions['food_drink']
        party.event_dress_code = event_conditions['event_dress_code'] if event_conditions['event_dress_code']
        party.cancellation_deadline = event_conditions['cancellation_deadline'] if event_conditions['cancellation_deadline']
            
        party.save  
      end
    end
    rescue Exception => e
      p e.message
    end    
  
  #p event_conditions
  #exit
end
#PartyJapan.create_post  
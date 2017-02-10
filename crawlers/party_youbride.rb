# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'
web_site_url = "https://party.youbride.jp"
page = agent.get("https://party.youbride.jp/search/")

event_detail_pages = []
  
page.search('//div[@class="MdCMN08ImgSetListP01"]//a').select{|link| link[:href] && link[:href].match(/party/)}.each do |link|
  event_detail_pages << link[:href]
end
next_page = page.search('//p[@class="mdCMN12Next"]//a').select{|link| link[:href] }
unless next_page.blank?
  next_page = next_page.first[:href]   
  begin
#    p "#####################################################"
#    p next_page
#    p "#####################################################"
    page = page.link_with(:href => next_page).click
    page.search('//div[@class="MdCMN08ImgSetListP01"]//a').select{|link| link[:href] && link[:href].match(/party/)}.each do |link|
      event_detail_pages << link[:href]
    end
    next_page = page.search('//p[@class="mdCMN12Next"]//a').select{|link| link[:href]}
    next_page = next_page.first[:href] unless next_page.blank?
  end while !next_page.blank?
end

#p event_detail_pages
#event_detail_pages << "/party/23260"

event_detail_pages.uniq.each do |detail_page_link|
  p detail_page_link
  event_id = detail_page_link.gsub('/party/','')
  event_url = web_site_url + detail_page_link
  detail_page = agent.get(event_url)
  detail_page = detail_page.search('//div[@class="LyMain"]')
  main_image_url = detail_page.search('//span[@class="MdThumb"]/img/@src').first.to_s
  title = detail_page.search('//div[@class="MdCMN08ImgSetListP04 MdMT0"]//h1').inner_text.strip
  description = detail_page.search('//div[@class="MdCMN11TxtSetP04"]').inner_text.strip.gsub('💛','').gsub('📨','').gsub('📩','') + "\r\n\r\n\r\n"
  description += detail_page.search('//div[@class="MdCMN11TxtSetP04 MdMT20"]').inner_text.strip.gsub('💛','').gsub('📨','').gsub('📩','')
  
  event_data = {}
  detail_page.search('//section[@class="ArCMN01PrgP02 BorderDotted"]').each do |section|
    event_data[section.search('h2').inner_text.gsub(/\s+/, "")] = section.search('p').inner_text.split(/['受付'|'\n'|'\r']/).compact.reject(&:blank?)
  end
  
  event_conditions = {}
  event_data.each do |type, data|
    if type == "開催日時"
      time = data[0].gsub(/\s+/, "").split(/['〜'|'('|')']/)
      event_conditions['event_date_time'] = DateTime.parse("#{time.first.gsub(/['年'|'月'|'日']/,'-')} #{time[2]} +900")
      event_conditions['event_start_time'] =  time[2]
      event_conditions['event_end_time'] = time[3]
      event_conditions['reception_time'] = data[1]
    elsif type == "服装"
      event_conditions['event_dress_code'] = data.first.gsub(/\s+/, "")
    elsif type == "持ち物"      
      event_conditions['personal_document'] = data.first.gsub(/\s+/, "")
    end
  end
  access_detail_all = detail_page.search('//div[@class="MdCMN10Map"]/p[@class="mdCMN10Txt"]').inner_text.split(/['\n'|'\r'|'\s+']/).compact.reject(&:blank?)
  access_detail_address = detail_page.search('//div[@class="MdCMN10Map"]/p[@class="mdCMN10Txt MdMT20"]').inner_text.split(/['\n'|'\r'|'\s+']/).compact.reject(&:blank?)
  p access_detail = access_detail_all - access_detail_address
  if access_detail.size > 2
    event_conditions['venue_name'] = [access_detail[0], access_detail[1]].join(' ')
    event_conditions['nearest_station'] = (access_detail - [access_detail[0]] - [access_detail[1]]).join(' ')
  else
    event_conditions['venue_name'] = access_detail[0]
    event_conditions['nearest_station'] = access_detail[1]
  end  
  address = access_detail_address.join(' ')
  event_conditions['address'] = address
  if address.match(/〒/)
    address = address.split(/['　'|' ']/)
    address = address[1]
  end
  prefecture_name = ""
  unless address.nil?
    if address.split(/['県']/).size > 1
      prefecture_name = address.split(/['県']/).first
    elsif address.split(/['府']/).size > 1      
      prefecture_name = address.split(/['府']/).first
    elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "京都"
      prefecture_name = "京都"
    elsif address.split(/['都']/).size > 1
      prefecture_name = address.split(/['都']/).first
    elsif address.split(/['区']/).size > 1 && ["千代田","中央","港","新宿","文京","台東","墨田","江東","品川","目黒","大田","世田谷","渋谷","中野","杉並","豊島","北","荒川","板橋","練馬","足立","葛飾","江戸川"].include?(address.split(/['区']/).first.strip) || address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "立川"
      prefecture_name = "東京"
    elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "名古屋"
      prefecture_name = "愛知"
    elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "大阪"
      prefecture_name = "大阪"
    elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "浜松"
      prefecture_name = "静岡"
    elsif address.split(/['市']/).size > 1 && address.split(/['市']/).first.strip == "神戸"
      prefecture_name = "兵庫"  
    elsif address.split('海道').size > 1 && address.split('海道').first.strip == "北"
      prefecture_name = "北海道"  
    end
  end
  event_conditions['postalcode'] = prefecture_name.gsub(/[\D]/, '')
  p "------------------------"
  p address
  p event_conditions['prefecture_name'] = prefecture_name.gsub(/[^\D]/, '').delete('〒-').squish
  p "------------------------"  
  
  
   ticket = detail_page.search('//div[@class="ArCMN01PrgP02 BorderDotted"]//div[@class="MdCMN06Ticket"]').first
   ticket_cond = ticket.search('//p[@class="mdCMN06Price"]').inner_text.split(/['\n'|'\r'|'\s+']/).compact.reject(&:blank?)
   
   male_ticket = ("男性" + ticket_cond.each_slice(ticket_cond.size / 2).first.join('#').split(/['男性'|'女性']/).compact.reject(&:blank?).first).split('#')
   female_ticket = ("女性" + ticket_cond.each_slice(ticket_cond.size / 2).first.join('#').split(/['男性'|'女性']/).compact.reject(&:blank?).last).split('#')
   [male_ticket, female_ticket].to_a.each do |t|
     
     if t.first == "男性"
       t.each_slice(2).to_a.each do |p|
         if p.first == "男性"
           event_conditions['price_for_male'] = p[1]
         elsif p.first == "早割"
           
         elsif p.first == "定員"
           event_conditions['reservation_limit_for_male'] = p[1] 
         else
           event_conditions['reservation_state_for_male'] = p[0]
         end
       end
     elsif t.first == "女性"
       t.each_slice(2).to_a.each do |p|
         if p.first == "女性"
           event_conditions['price_for_female'] = p[1]
         elsif p.first == "早割"
         elsif p.first == "定員"
           event_conditions['reservation_limit_for_female'] = p[1]
         else
           event_conditions['reservation_state_for_female'] = p[0]
         end
       end
     end
   end
  
   age_range = ticket.search('//p[@class="mdCMN06Quality"]').inner_text.split(/['\n'|'\r'|'\s+']/).compact.reject(&:blank?)
   male_age_range = age_range[0].split('、')
   female_age_range = age_range[1].split('、')
   event_conditions['age_range_for_male'] = male_age_range.first 
   event_conditions['age_range_for_female'] = female_age_range.first
   event_conditions['eligibility_for_male'] = (male_age_range - [male_age_range.first]).join('、') 
   event_conditions['eligibility_for_female'] = (female_age_range - [female_age_range.first]).join('、')
   event_conditions['cancellation_policy'] = detail_page.search('//ul[@class="MdCMN04ListP01"]/li').inner_text

   begin  
     Youbride.transaction do  
       Youbride.where(id: event_id).first_or_initialize.tap do |bride| 
         bride.id = event_id
         bride.event_url = event_url
         bride.main_image_url = main_image_url
         bride.title = title
         bride.description = description
         bride.postalcode = event_conditions['postalcode'] if event_conditions['postalcode']
         bride.prefecture_name = event_conditions['prefecture_name'] if event_conditions['prefecture_name']
         bride.address = event_conditions['address'] if event_conditions['address']
         
         bride.event_date_time = event_conditions['event_date_time'] if event_conditions['event_date_time']
         bride.event_start_time = event_conditions['event_start_time'] if event_conditions['event_start_time']
         bride.event_end_time = event_conditions['event_end_time'] if event_conditions['event_end_time']
         bride.reception_time = event_conditions['reception_time'] if event_conditions['reception_time']

         bride.reservation_state_for_male = event_conditions['reservation_state_for_male'] if event_conditions['reservation_state_for_male'] 
         bride.reservation_state_for_female = event_conditions['reservation_state_for_female'] if event_conditions['reservation_state_for_female']  
          #conditions
         bride.cancellation_policy = event_conditions['cancellation_policy'] if event_conditions['cancellation_policy']
         bride.venue_name = event_conditions['venue_name'] if event_conditions['venue_name']
         bride.nearest_station = event_conditions['nearest_station'] if event_conditions['nearest_station']
         bride.price_for_male = event_conditions['price_for_male'] if event_conditions['price_for_male']
         bride.price_for_female = event_conditions['price_for_female'] if event_conditions['price_for_female']
            
         bride.age_range_for_male = event_conditions['age_range_for_male'] if event_conditions['age_range_for_male']
         bride.age_range_for_female = event_conditions['age_range_for_female'] if event_conditions['age_range_for_female']
         bride.eligibility_for_male = event_conditions['eligibility_for_male'] if event_conditions['eligibility_for_male']
         bride.eligibility_for_female = event_conditions['eligibility_for_female'] if event_conditions['eligibility_for_female']   
            
         bride.reservation_limit_for_male = event_conditions['reservation_limit_for_male'] if event_conditions['reservation_limit_for_male']
         bride.reservation_limit_for_female = event_conditions['reservation_limit_for_female'] if event_conditions['reservation_limit_for_female']
            
         bride.save  
       end
     end
   rescue Exception => e
     #p e.backtrace.join("\n")
     p e.message    
   end
end


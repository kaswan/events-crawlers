# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'
web_site_url = "https://www.ptotjinzaibank.com"
page = agent.get("https://www.ptotjinzaibank.com/")

page.search('//div[@class="melon-box-white"]//a').select{|link| link && link[:href] && link[:href].match(/area/) }.each do |link|
  offer_page_links = []
  full_link = web_site_url + link[:href]
  sleep(10)  
  result_page = agent.get(full_link)
  offer_arr = {}
  #result_page.search('//div[@class="melon-resultBox_header"]//a').select{|link| link && link[:href] && link[:href].match(/offer/) }.each do |dlink|
  result_page.search('//div[@class="melon-resultBox_header"]').each do |dlink|
    dtl = dlink.search('a').first[:href] 
    offer_page_links << dtl
    id = dtl.split('.html').first.split('/').last
     header_text = dlink.search('ul//li').last.inner_text.squish
     if !header_text.match(/月/).nil? && !header_text.match(/日/).nil?
       (offer_arr[id]||={})['calendar_date'] = header_text
       pt = PtotJinzaiBank.where(id: id.to_i)
       unless pt.first.nil?
         pt.first.update_columns(:calendar_date => header_text)
       end  
     end
  end
  
  total_result = result_page.search('//strong[@class="melon-f-16"]').inner_text
  if total_result.to_i > 10
    total_pages = total_result.to_i % 10 ? (total_result.to_i / 10) + 1 : (total_result.to_i / 10) 
    # Go to next_page and collect offer page link  
    (2..total_pages).each do |page|
      x = link[:href].split('/')
      x[-1] = link[:href].split('/').last.sub(x[-1], page.to_s)
      next_page_link = web_site_url + x.join('/')
      sleep(5)
      begin
        p next_page_link
        result_page = agent.get(next_page_link)
        result_page.search('//div[@class="melon-resultBox_header"]//a').select{|link| link && link[:href] && link[:href].match(/offer/) }.each do |dlink|
          offer_page_links << dlink[:href]    
        end
      rescue Timeout::Error
        p "caught Timeout::Error!"
      rescue Net::HTTPServiceUnavailable
        p "Caught fetch 503 Error!"
      rescue Exception => e
        p e.backtrace.join("\n")    
      end
    end
  end
  
  already_exists = PtotJinzaiBank.all.map(&:id)  
  offer_page_links.each do |offer|
    id = offer.split('.html').first.split('/').last
    next if already_exists.include?(id.to_i)
    
    p full_link = web_site_url + offer
    sleep(10)
    begin 
      detail_page = agent.get(full_link)
      (offer_arr[id]||={})['page_url'] = full_link 
      (offer_arr[id]||={})['title'] = detail_page.search('//div[@class="hospital-name"]//h1').inner_text.strip
      (offer_arr[id]||={})['sub_title'] = detail_page.search('//div[@class="container01"]//p').inner_text.strip
      
      detail_page.search('//table[@class="melon-table melon-table-horizon melon-f-10L"]').each do |table|
        table.search('tr').each do |dt|
          if dt.at('th')
            if dt.at('th').inner_text.strip == "特徴"
              ((offer_arr[id]||={})[dt.at('th').inner_text.strip]||=[]) << dt.at('td').inner_text.strip  
            else
              (offer_arr[id]||={})[dt.at('th').inner_text.strip] = dt.at('td').inner_text.strip
            end      
          end
        end
        p "###################"
      end
        
      ######################## SAVE TO DATABASE TABLE ###################################
      
      offer_detail = offer_arr[id]
      unless offer_detail["勤務地"].blank?
        p offer_detail["勤務地"]
        location = offer_detail["勤務地"].split(/['\r\n']/).compact.reject(&:blank?)          
        if !location.nil? 
          if location.size > 1
            postalcode = location.first.strip 
            address = location.last.strip
          else
            address = location.first.strip
          end  
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
          
          prefecture_name = "東京" if prefecture_name == "東京都"
        end
      end
      
      begin  
        PtotJinzaiBank.transaction do  
          PtotJinzaiBank.where(id: id.to_i).first_or_initialize.tap do |of| 
            of.id = id.to_i
            of.page_url = offer_detail['page_url']
            of.title = offer_detail['title']
            of.sub_title = offer_detail['sub_title']
            of.job_feature = offer_detail["特徴"].first.split(/["\n" " " " "]/).compact.reject(&:blank?).join(",") if offer_detail["特徴"] 
            of.salary = offer_detail["給与"] if offer_detail["給与"] 
            of.working_hours = offer_detail["勤務時間"] if offer_detail["勤務時間"] 
            of.holiday_vacation = offer_detail["休日・休暇"] if offer_detail["休日・休暇"] 
            of.job_category = offer_detail["募集職種"] if offer_detail["募集職種"] 
            of.employment_type = offer_detail["雇用形態"] if offer_detail["雇用形態"] 
            of.job_detail = offer_detail["業務内容"] if offer_detail["業務内容"] 
            of.recommended_comment = offer_detail["キャリアパートナーのおすすめコメント"] if offer_detail["キャリアパートナーのおすすめコメント"]
            of.workplace_feature = offer_detail["特徴"].last.split(/["\n" " " " "]/).compact.reject(&:blank?).join(",") if offer_detail["特徴"]
            of.corporate_name = offer_detail["法人名"] if offer_detail["法人名"]
            of.office_name = offer_detail["事業所名"] if offer_detail["事業所名"]
            of.institution_type = offer_detail["施設形態"] if offer_detail["施設形態"]
            of.work_location = offer_detail["勤務地"] if offer_detail["勤務地"] 
            of.postalcode = postalcode if postalcode
            of.prefecture = prefecture_name if prefecture_name
            of.nearest_station = offer_detail["最寄交通機関"] if offer_detail["最寄交通機関"]
            of.calendar_date = offer_detail["calendar_date"] if offer_detail["calendar_date"]
            # SAVE HERE  
            of.save
          end
        end
      rescue Exception => e
        p e.backtrace.join("\n")    
      end  
      
      ###############################################################
      #break;
    rescue Timeout::Error
      p "caught Timeout::Error!"  
    rescue Net::HTTPServiceUnavailable
      p "Caught fetch 503 Error!"  
    rescue Exception => e
      p e.backtrace.join("\n")    
    end  
  end
  #break;  
end

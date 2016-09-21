# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'
web_site_url = "http://www.otocon.jp"
page = agent.get("http://www.otocon.jp/search/?/m=50/w=50/")

event_detail_pages = []
page.search('//ul//h3//a').select{|link| link[:href] && link[:href].match(/detail.html/)}.each do |link|
  event_detail_pages << link[:href]
end

next_page = page.search('//p[@class="pager"]//span//a').select{|link| link[:href] && link.inner_text == "次の10件>" }.first[:href]
#begin
#  p "#####################################################"
#  p next_page
#  p "#####################################################"
#  page = page.link_with(:href => next_page).click
#  page.search('//ul//h3//a').select{|link| link[:href] && link[:href].match(/detail.html/)}.each do |link|
#    event_detail_pages << link[:href]
#  end
#  next_page = page.search('//p[@class="pager"]//span//a').select{|link| link[:href] && link.inner_text == "次の10件>" }
#  next_page = next_page.first[:href] unless next_page.blank?
#end while !next_page.blank?
#
#p event_detail_pages.size
event_detail_pages << "/party/detail.html$/party_id/9819/"
event_detail_pages.uniq.each do |detail_page_link|
  p detail_page_link
  event_id = detail_page_link.gsub('/party/detail.html$/party_id/','').gsub('/','')
  event_url = web_site_url + detail_page_link
  detail_page = agent.get(detail_page_link)
  title = detail_page.search('//div[@id="party-body-hed"]//h3').inner_text.strip
  target = detail_page.search('//div[@id="party-body-hed"]//h4').inner_text.strip
  
  reservation_state_for_male = detail_page.search('//div[@id="party-body-hed"]//table[@class="table-ojt_twin"]//td').first.search('img/@alt').to_s
  reservation_state_for_female = detail_page.search('//div[@id="party-body-hed"]//table[@class="table-ojt_twin"]//td').last.search('img/@alt').to_s
  
  event_date_time_detail = detail_page.search('//div[@class="partyList-date"]//table').at('tr').search('td').inner_text.strip.gsub(/['\n']/,'').split(/['（','）']/)
  p event_date = Date.parse(event_date_time_detail.first.gsub(/['年','月','日']/,'-'))
    p event_date_time_detail
  p event_start_time =  event_date_time_detail[2].split('〜').first
  p event_end_time =  event_date_time_detail[2].split('〜').last
  p reception_time = event_date_time_detail[3].gsub('受付時間：','')
    
  
  detail_page.search('//div[@id="party-body"]//div[@class="partyList-table"]/table').last.search('tr').each do |tr|
    p tr.at('th/img/@alt').to_s
    tr.at('td/table').search('tr').each do |ctr|
      p ctr.inner_text
    end unless tr.at('td/table').nil?
  end
  exit
end
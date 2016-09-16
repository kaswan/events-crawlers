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

p event_detail_pages.size
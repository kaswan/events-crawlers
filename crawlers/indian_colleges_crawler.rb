# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'

page = agent.get("http://www.collegedekho.com/")
sleep(3)
resume_switch = false
page_link_lists ||= []

csv_lists = []
header_lists = []
header_lists << "Site-Url"  
  

  #prefecture_page = page.link_with(:text => '').click
    
  page_links = page.search('//div[@class="streams-area"]//a').select{|link| link[:href] && link[:href].match(/colleges-in-india/)}
  p "#####################"
  #p page_links
if !page_links.empty?
  ar={}
  page_links.each{|l| (ar[l.search('span[@class="card-text-back courses"]//span').inner_text.strip] ||= []) << l[:href]}
    #p ar
    
    page_links.each do |link|
      department = link.children.search('span[@class="card-text-back courses"]//span').inner_text
      p "***************************************************************************"
      detail_page = page.link_with(:href => link[:href]).click
      
      #detail_page.link(:class => "btn btn-primary show-more-button").click
      #detail_page.search('//button[@class="btn btn-primary show-more-button"]').select.click
      next_page = detail_page.at(".show-more-button")
      # mech is your Mechanize object.
      next_link = Mechanize::Page::Link.new( next_page, agent, detail_page )
      next_link.click
      sleep(3)
      next_page = detail_page.at(".show-more-button")
            # mech is your Mechanize object.
            next_link = Mechanize::Page::Link.new( next_page, agent, detail_page )
            next_link.click
      sleep(3)      
      data_lists = detail_page.search('//div[@id="filter-results"]//div').search('div[@class="row"]')
      college_lists = {}
      data_lists.each_with_index do |d,i|
        (((college_lists[department] ||= {})[i] ||= {})['college_name'] ||=[]) << d.children.search('div[@class="college-name"]//a').inner_text.strip
        (((college_lists[department] ||= {})[i] ||= {})['college_city'] ||=[]) << d.children.search('div[@class="college-city"]').inner_text.strip
        (((college_lists[department] ||= {})[i] ||= {})['college_course_level'] ||=[]) << d.children.search('div[@class="col-md-4 course-level"]//ul').inner_text.strip.gsub(/[' ','　']/,'').gsub(/['\n']/,',').split(',').reject(&:empty?).uniq
        
      end
      p college_lists
      break
    end
end

#  while !page_links.empty?
#    ar=[]
#    p "#####################"
#    page_links.each{|l| ar << l[:href]}
#    p ar.uniq
    
#    page_links.each do |link|
#      #detail_page = prefecture_page.link_with(:href => link[:href])
#      page_link_lists << link[:href] 
#      detail_page = prefecture_page.link_with(:href => link[:href]).click
#      data_lists = detail_page.search('//div[@id="tab-outline-ad"]//table[@class="detail"]//tr').select
#      lists = {}
#      data_lists.each do |d|
#        ths = d.search('th')
#        tds = d.search('td')
#        index = 0
#        ths.each do |th|
#          val = ''
#          if th[:rowspan].to_i == 0
#            val = tds[index].nil? ? '' : tds[index].inner_text.gsub("\n", '').gsub("\r", '').gsub("\t", '').strip
#          else
#            th[:rowspan].to_i.times do
#              val = val + (tds[index].nil? ? '' : tds[index].inner_text.gsub("\n", '').gsub("\r", '').gsub("\t", ''))
#              index += 1
#            end
#          end
#          lists["都道府県"] = prefecture.name
#          lists["Site-Url"] = "http://kaigodb.com" + link[:href]
#          unless th.nil? 
#            lists[th.inner_text.strip] = val
#            header_lists << th.inner_text.strip
#          end   
#          #p th.inner_text + " => " + course_name    
#        end
#      end
#      csv_lists << lists
#      
#    end
#    
#    next_link = page.search('//div[@class="pagenation"]//span[@class="next"]//a').select{|link| link[:href]}
#    if !next_link.empty?  
#      next_link.each do |link|
#        #p link[:href]
#        prefecture_page = prefecture_page.link_with(:href => link[:href]).click
#        sleep(4)
#        page_links = prefecture_page.search('//table[@class="clist-table gaClickTrack_list"]//a').select{|link| link[:href] && link[:href].match(/jigyousho/)}  
#      end
#    else
#      page_links = []
#    end
    
#  end
  #p page_link_lists.uniq
  #p page_link_lists.uniq.count
  #p page_links.first
  #p header_lists.uniq
  #p csv_lists
  #break
#end

#outfile = "test_kaigo.csv"
#csv_udata = CSV.generate do |csv|
#  csv << header_lists.uniq
#  csv_lists.each do |line|
#    data_arr = []
#    header_lists.uniq.each do |field|
#      if line[field].blank?
#        data_arr << ''
#      else
#        data_arr << line[field]
#      end
#    end
#    csv << data_arr
#  end    
#end

#p  csv_udata

#path = "public/kaigo_data_download.csv"
#file = File.open(path,'w')
#file.write(csv_udata)
#file.close()
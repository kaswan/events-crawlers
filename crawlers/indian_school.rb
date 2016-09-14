# -*- coding: utf-8 -*-
require 'csv'
agent ||= Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:23.0) Gecko/20100101 Firefox/23.0'

page = agent.get("http://schoolreportcards.in/SRC-New/SchoolDirectory/Directory.aspx")

form =  page.form_with(:name => 'aspnetForm')
form.field_with(:class => 'jqx-combobox-input jqx-widget-content jqx-rc-all'){|field| field.value = 'Rajasthan'}
result = form.submit
p result.body
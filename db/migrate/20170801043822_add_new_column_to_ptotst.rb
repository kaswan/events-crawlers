class AddNewColumnToPtotst < ActiveRecord::Migration
  def change
    add_column :ptot_jinzai_banks, :calendar_date, :string, :after => :page_url
    add_column :ot_jinzai_banks, :calendar_date, :string, :after => :page_url
    add_column :st_jinzai_banks, :calendar_date, :string, :after => :page_url
  end
end

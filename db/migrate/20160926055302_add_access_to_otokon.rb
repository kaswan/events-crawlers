class AddAccessToOtokon < ActiveRecord::Migration
  def change
    add_column :otokon_japans, :access, :text, :after => :address
  end
end

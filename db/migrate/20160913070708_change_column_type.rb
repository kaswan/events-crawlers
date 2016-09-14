class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :exeo_japans, :important_reminder,  :text
  end
end

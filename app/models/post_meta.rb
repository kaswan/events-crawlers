class PostMeta < ActiveRecord::Base
  self.primary_key = 'meta_id'
  self.table_name = 'wpf0c254postmeta'
  belongs_to :post, foreign_key: :post_id
  attr_accessible :post_id, :meta_key, :meta_value
end
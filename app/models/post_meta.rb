class PostMeta < ActiveRecord::Base
  self.primary_key = 'meta_id'
  self.table_name = 'post_metas'
  belongs_to :post, class_name: 'Post'
  attr_accessible :post_id, :meta_key, :meta_value
end
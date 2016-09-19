class Post < ActiveRecord::Base  
  self.primary_key = 'ID'
  self.table_name = 'wpf0c254posts'
  belongs_to :parent, polymorphic: true
  has_many :post_metas, foreign_key: :post_id
  has_many :term_relations, foreign_key: :object_id
  accepts_nested_attributes_for :post_metas, allow_destroy: true
  accepts_nested_attributes_for :term_relations, allow_destroy: true

  before_create do
    self.post_date = DateTime.now
    self.post_author = '1'
    self.post_date = DateTime.now 
    self.post_date_gmt = DateTime.now 
    #self.post_status = 'publish'
    self.post_modified = DateTime.now
    self.post_modified_gmt = DateTime.now
    self.post_excerpt = ''
    self.to_ping = ''
    self.pinged = ''
    self.post_content_filtered = ''
  end
  
end
class Post < ActiveRecord::Base  
#  include  ActiveModel::MassAssignmentSecurity
  self.primary_key = 'ID'
  self.table_name = 'wpf0c254posts'
  has_many :post_metas, foreign_key: :post_id
  accepts_nested_attributes_for :post_metas, allow_destroy: true
#  has_many :post_metas, class_name: 'PostMeta', foreign_key: 'post_id' 
#  accepts_nested_attributes_for :post_metas, allow_destroy: true
#  #before_create :initialize
#  attr_accessible :post_date, :post_author, :post_date, :post_date_gmt, :post_modified, :post_modified_gmt, :post_title, :post_content, :guid
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
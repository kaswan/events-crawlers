class TermRelation < ActiveRecord::Base
  self.primary_key = 'object_id'
  self.table_name = 'wpf0c254term_relationships'
  belongs_to :post, foreign_key: :object_id
  attr_accessible :object_id, :term_taxonomy_id, :term_order
end
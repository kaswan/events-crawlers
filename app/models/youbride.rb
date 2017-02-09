class Youbride < ActiveRecord::Base
  has_one :post, as: :parent
  default_scope { order(updated_at: :desc) }
end

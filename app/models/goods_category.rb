class GoodsCategory < ActiveRecord::Base
  belongs_to :good
  belongs_to :category
end

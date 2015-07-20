class Good < ActiveRecord::Base
  has_many :good_specs
  has_many :goods_categories
  has_many :categories, through: :goods_categories  
end

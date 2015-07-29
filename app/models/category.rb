class Category < ActiveRecord::Base
  has_many :goods_categories
  has_many :goods, through: :goods_categories


  enum category_type: {
    normal:             0,      # 待发布的(没有添加规格的产品是不允许被发布的)
    partition:          1,      # 已经发布的    
  }
    
end

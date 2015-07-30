class Category < ActiveRecord::Base
  has_many :goods_categories
  has_many :goods, through: :goods_categories


  enum category_type: {
    normal:             0,      # 普通分类
    partition:          1,      # 分区
  }
    
end

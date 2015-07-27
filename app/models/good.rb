class Good < ActiveRecord::Base
  has_many :good_specs
  has_many :goods_categories, class_name: 'GoodsCategory'
  has_many :categories, through: :goods_categories

  default_scope { order('id desc') }

  enum status: {
    pending:               0,      # 待发布的(没有添加规格的产品是不允许被发布的)
    published:             1,      # 已经发布的
    shortage:              -1      # 缺货
  }

end

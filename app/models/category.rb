class Category < ActiveRecord::Base
  has_many :goods_categories
  has_many :goods, through: :goods_categories

  enum category_type: {
    normal:             0,      # 普通分类
    partition:          1,      # 分区
  }


  enum status: {
    show:    0,
    hidden:  1
  }


  def status_str
    case status
    when 'show'
      '显示中'
    when 'hidden'
      '隐藏中'
    end
  end
    
end

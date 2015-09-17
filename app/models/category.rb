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

  store :ext, accessors: [:asset_id]

  def status_str
    case status
    when 'show'
      '显示中'
    when 'hidden'
      '隐藏中'
    end
  end

  def photo_url
    if asset_id.present?
      Asset.find(asset_id).resource_url
    else
      if goods.first.present?
        goods.first.photo_urls.first
      else
        ''
      end
    end
  end
    
end

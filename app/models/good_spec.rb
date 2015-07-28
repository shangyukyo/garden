class GoodSpec < ActiveRecord::Base
  belongs_to :good

  attr_accessor :photo_urls

  enum status: {          
    normal:   0,
    shortage: -1      # 缺货
  }


  def photo_urls
    Asset.where(id: photo_asset_ids.split(',')).map(&:resource_url)
  end
end

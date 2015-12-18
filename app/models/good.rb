class Good < ActiveRecord::Base
  has_many :good_specs
  has_many :goods_categories, class_name: 'GoodsCategory'
  has_many :categories, through: :goods_categories

  acts_as_taggable

  store :ext, accessors: [:unit, :address, :partition_photo, :category_photo, :cover_photo]

  # default_scope { order('id desc') }

  enum status: {
    pending:               0,      # 待发布的(没有添加规格的产品是不允许被发布的)
    published:             1,      # 已经发布的
    shortage:              -1      # 缺货
  }

  def photo_urls
    Asset.where(id: photo_asset_ids.split(',')).map(&:resource_url)
  end  

  def description_url
    "http://101.200.197.162:9004/api/goods/#{self.id}/description"
  end

  def index_photo_url
    Asset.find_by(id: partition_photo).try(:resource_url) || photo_urls.first
  end

  def cover_photo_url
    Asset.find_by(id: cover_photo).try(:resource_url) || photo_urls.first
  end

end

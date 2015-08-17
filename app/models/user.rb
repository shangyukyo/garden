class User < ActiveRecord::Base

  validates :mobile, uniqueness: true, presence: true
  validates :private_token, uniqueness: true, presence: true

  has_many :user_shippings
  has_many :orders

  mount_uploader :avatar, AvatarUploader

  def generate_private_token
    loop do
      self.private_token = SecureRandom.hex(16)
      break if not User.find_by(private_token: private_token).present?    
    end
  end

  def avatar_url_thumb
    avatar_url(:thumb)
  end

  #下单
  def placed!(user_shipping_id, goods_info)
    ActiveRecord::Base.transaction do 
      begin
        total_price = total_quantity  = 0        
        order          = orders.build
        user_shipping  = user_shippings.find(user_shipping_id)

        order.shipping = user_shipping.as_json(except: [:created_at, :updated_at])
        order.save!

        goods_info.each do |good_info|

          good                      = Good.find good_info["good_id"]
          quantity                  = good_info["quantity"].to_i

          order_good                = order.order_goods.build
          order_good.good_id        = good.id
          order_good.price          = good.price
          order_good.quantity       = quantity
          order_good.good_snapshot  = good.as_json(except: [:status, :created_at, :updated_at, :deleted_at])
          order_good.save!

          total_quantity += quantity
          total_price += (order_good.price * quantity)
        end

        order.origin_total_price = total_price
        order.total_price = total_price
        order.quantity = total_quantity
        order.save!

        order
      rescue => e
        raise e
        raise ActiveRecord::Rollback
      end

    end

  end
  
end

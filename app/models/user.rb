class User < ActiveRecord::Base

  validates :mobile, uniqueness: true, presence: true
  validates :private_token, uniqueness: true, presence: true

  has_many :user_shippings
  has_many :orders

  has_many :user_coupons, -> { where(status: UserCoupon.statuses[:pending]) }
  has_many :coupons, through: :user_coupons

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
  def placed!(user_shipping_id, goods_info, coupon_id)
    ActiveRecord::Base.transaction do 
      begin
        total_price = total_quantity  = 0        
        order          = orders.build
        user_shipping  = user_shippings.find(user_shipping_id)
        coupon         = coupons.find_by(id: coupon_id)

        order.shipping = user_shipping.as_json(except: [:created_at, :updated_at])
        order.save!

        goods_info.each do |good_info|

          good                      = Good.find good_info["good_id"]
          quantity                  = good_info["quantity"].to_i

          order_good                = order.order_goods.build
          order_good.good_id        = good.id
          order_good.price          = good.price * quantity
          order_good.quantity       = quantity
          order_good.good_snapshot  = good.as_json(except: [:status, :created_at, :updated_at, :deleted_at])
          order_good.save!

          total_quantity += quantity
          total_price += (order_good.price * quantity)
        end

        if coupon.present?
          
          if coupon.start_at < Time.now and coupon.expired_at > Time.now
            raise "优惠券已过有效期或未到有效期!"
          end

          total_price -= coupon.price
          use_coupon(coupon.id)
          order.coupon = coupon.as_json(except: [:created_at, :updated_at])
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


  def use_coupon coupon_id
    user_coupons.find_by(coupon_id: coupon_id).used!
  end
  
end

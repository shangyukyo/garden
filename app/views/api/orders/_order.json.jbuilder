json.(order, :id, :user_id, :order_no, :origin_total_price, :total_price, :quantity, :status, :cover_url, :shipping, :warehouse, :pick_up_code, :coupon, :created_at)

json.goods do
  json.partial! '/api/orders/order_goods', collection: order.order_goods, as: :order_good    
end


json.(order, :id, :user_id, :order_no, :total_price, :quantity, :status, :cover_url, :shipping, :warehouse, :coupon, :created_at)

json.goods do
  json.partial! '/api/orders/order_goods', collection: order.order_goods, as: :order_good    
end


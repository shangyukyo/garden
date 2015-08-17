json.(order, :id, :user_id, :order_no, :total_price, :quantity, :status, :cover_url, :shipping, :created_at)

json.goods do
  json.partial! '/api/goods/good', collection: order.goods, as: :good
end

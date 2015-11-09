json.(order_good.good, :id, :name, :description, :unit, :address, :photo_urls)
json.quantity order_good.quantity
json.price order_good.good_snapshot["price"]
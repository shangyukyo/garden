json.(partition, :id, :name, :photo_url, :created_at)

json.goods do 
  json.partial! '/api/goods/good', collection: partition.goods, as: :good
end
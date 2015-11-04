json.(category, :id, :name, :photo_url, :created_at)

json.goods do 
  json.partial! '/api/goods/good', collection: category.goods.published, as: :good
end
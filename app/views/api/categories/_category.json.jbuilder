json.(category, :id, :name, :created_at)

json.goods do 
  json.partial! '/api/goods/good', collection: category.goods, as: :good
end
json.(region, :id, :name, :created_at)

json.warehouses do 
  json.partial! '/api/cities/warehouse', collection: region.warehouses, as: :warehouse
end


json.(city, :id, :name, :created_at)

json.regions do 
  json.partial! '/api/cities/region', collection: city.regions, as: :region
end


json.(city, :id, :name, :created_at)

json.areas do 
  json.partial! '/api/cities/area', collection: city.areas, as: :area
end

json.schools do 
  json.partial! '/api/cities/school', collection: city.schools, as: :school
end
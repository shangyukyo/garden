json.(poster, :id, :photo_url, :good_id, :created_at, :updated_at)

json.good do 
  json.partial! '/api/goods/good', good: poster.good
end
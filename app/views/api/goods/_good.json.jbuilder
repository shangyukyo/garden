json.(good, :id, :name, :description, :created_at, :updated_at)

json.good_specs do 
  json.partial! '/api/good_specs/good_spec', collection: good.good_specs, as: :good_spec
end
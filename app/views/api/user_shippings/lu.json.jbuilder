json.array! @provinces do |province|
  json.(province, :id, :name)

  json.cities province.cities do |city|
    json.(city, :id, :name)

    json.regions city.regions do |region|
      json.(region, :id, :name)
    end

  end

end




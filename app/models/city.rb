class City < ActiveRecord::Base


  def areas
    Area.where(city: name)
  end

  def schools
    School.where(city: name)
  end
  
end

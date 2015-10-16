class City < ActiveRecord::Base

  has_many :regions  

  def areas
    Area.where(city: name)
  end

  def schools
    School.where(city: name)
  end
  
end

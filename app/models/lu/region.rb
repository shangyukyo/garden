class Lu::Region < ActiveRecord::Base

  def city
    Lu::City.find_by(city_id: self.father_id)
  end

end

# class Lu::Province < ActiveRecord::Base


#   def self.build_related_city_region
#     ret = {}
#     self.all.each do |province|
#       ret[province] = {}
#       ret[province][:city]    = province.cities
#       ret[province][:region]  = province.regions
#     end
#     ret
#   end


#   def cities
#     Lu::City.where(father_id: province_id)
#   end

#   def regions
#     Lu::Region.where(father_id: cities.map(&:city_id))
#   end

# end

class Region < ActiveRecord::Base
  belongs_to :city
  has_many :warehouses
end

class OrderGood < ActiveRecord::Base
  belongs_to :order
  belongs_to :good

  store :ext, accessors: [:good_snapshot]
end

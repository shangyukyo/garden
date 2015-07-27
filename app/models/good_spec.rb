class GoodSpec < ActiveRecord::Base
  belongs_to :good

  attr_accessor :photo_urls

  enum status: {          
    normal:   0,
    shortage: -1      # 缺货
  }

end

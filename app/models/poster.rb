class Poster < ActiveRecord::Base

  belongs_to :good, foreign_key: :good_id
  belongs_to :poster_asset, foreign_key: :asset_id


  def photo_url
    self.poster_asset.resource_url(:middle)              
  end

end

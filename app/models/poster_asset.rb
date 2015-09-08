class PosterAsset < ActiveRecord::Base
  self.table_name = 'assets'

  mount_uploader :resource, PosterUploader
end

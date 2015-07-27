class Asset < ActiveRecord::Base
  mount_uploader :resource, BaseUploader
end

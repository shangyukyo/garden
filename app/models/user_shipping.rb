class UserShipping < ActiveRecord::Base
  belongs_to :user

  def defaults
    default
  end

end

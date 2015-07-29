class User < ActiveRecord::Base

  validates :mobile, uniqueness: true, presence: true
  validates :private_token, uniqueness: true, presence: true

  has_many :user_shippings

  mount_uploader :avatar, AvatarUploader

  def generate_private_token
    loop do
      self.private_token = SecureRandom.hex(16)
      break if not User.find_by(private_token: private_token).present?    
    end
  end

  def avatar_url_thumb
    avatar_url(:thumb)
  end
  
end
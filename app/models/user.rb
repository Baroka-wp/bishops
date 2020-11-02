class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i(google)
   mount_uploader :avatar, AvatarUploader


  has_many :startups

  def avatar_thumbnail
    if avatar.present?
      avatar.url
    else
      '/default-avatar.png'
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
   user = User.find_by(email: auth.info.email)
   user ||= User.new(email: auth.info.email,
                     name: auth.info.name,
                     provider: auth.provider,
                     uid: auth.uid,
                     password: Devise.friendly_token[0, 20])
   user.save
   user
 end
end

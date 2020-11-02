class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
   mount_uploader :avatar, AvatarUploader

  def avatar_thumbnail
    unless avatar.nil?
      avatar.url
    else
      '/default-avatar.png'
    end
  end
end

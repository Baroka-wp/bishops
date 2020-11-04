class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i(google)
   mount_uploader :avatar, AvatarUploader

   validates :name , presence: true , uniqueness: true
   has_many :startups, dependent: :destroy
   has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
   has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
   has_many :following, through: :active_relationships, source: :followed
   has_many :followers, through: :passive_relationships, source: :follower
   has_many :favorites, dependent: :destroy
   has_many :comments, dependent: :destroy

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

 def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end

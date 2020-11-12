class Startup < ApplicationRecord
  mount_uploader :logo, LogoUploader
  mount_uploader :banner, BannerUploader

  validates :name, presence:true, uniqueness: true,  null:false
  validates :resume, presence:true, null:false, length:{minimum: 150}
  validates :contact, presence:true, null:false
  validates :adresse, presence:true, null:false
  validates :sector_of_business, presence:true, null:false
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  enum sector_of_business: %i[agriculture it education transport tourism public_service trade]

  belongs_to :user


  def logo_thumbnail
    if logo.present?
      logo.url
    else
      '/default_logo.png'
    end
  end

  def banner_thumbnail
    if banner.present?
      banner.url
    else
      '/banner.gif'
    end
  end

  def description_thumbnail
    if video.present?
      video
    else
      "https://www.youtube.com/watch?v=NGi5ontIT3w"
    end
  end
end

class User < ApplicationRecord
  has_secure_password

  validates :email_address, presence: true, uniqueness: true
  validates :name, 
            presence: true, 
            length: { minimum: 2, maximum: 20 },
            uniqueness: true
  
  validates :introduction, length: { maximum: 50 }

  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :books, dependent: :destroy

  has_one_attached :profile_image

  
  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(
        resize_to_limit: [width, height]
      ).processed
    else
      ActionController::Base.helpers.asset_path("no_image.jpg")
    end
  end
end
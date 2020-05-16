class User < ApplicationRecord
  has_many :blogs
  has_many :comments
  mount_uploader :avater, AvatarUploader
  mount_uploader :id_card, AvatarUploader
  has_secure_password
  validates :username, uniqueness: true, allow_blank: true
  validates :email, presence: true, uniqueness: true
end

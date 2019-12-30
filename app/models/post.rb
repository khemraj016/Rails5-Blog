class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, :user_id, :image, presence: true

  belongs_to :user

  has_many :comments, dependent: :destroy
end

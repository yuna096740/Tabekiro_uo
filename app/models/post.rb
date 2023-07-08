class Post < ApplicationRecord

  belongs_to :member
  belongs_to :tag

  validates :post_image, presence: :true

  has_one_attached :post_image
end

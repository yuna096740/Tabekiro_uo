class Post < ApplicationRecord

  belongs_to :member
  belongs_to :tag
  has_many   :post_comments, dependent: :destroy

  validates :post_image, presence: :true

  has_one_attached :post_image

  def get_post_image(width, height)
    post_image.variant(resize_to_fill: [width, height]).processed
  end
end

class Post < ApplicationRecord

  default_scope -> { order(created_at: "DESC") }
  enum open_status: { open: 0, unopened: 1,complete: 2 }

  belongs_to :member
  belongs_to :tag
  has_many   :post_comments, dependent: :destroy
  has_many   :favorites, dependent: :destroy

  validates :post_image, presence: :true

  has_one_attached :post_image

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no-icon.jpg')
      post_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    post_image.variant(resize_to_fill: [width, height]).processed
  end

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def self.search(keyword)
    where(["title LIKE? or introduction LIKE? or place_name LIKE?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
end

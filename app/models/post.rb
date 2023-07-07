class Post < ApplicationRecord

  belongs_to :member
  belongs_to :tag

  has_one_attached :image
end

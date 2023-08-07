class VisionTag < ApplicationRecord
  has_many :vision_tag_relationships, dependent: :destroy
end

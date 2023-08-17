class VisionTag < ApplicationRecord
  has_many :vision_tag_relationships, dependent: :destroy
  has_many :posts, through: :vision_tag_relationships

  def self.search(name)
    where("name LIKE?", "#{name}")
  end
end

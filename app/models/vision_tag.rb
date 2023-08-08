class VisionTag < ApplicationRecord
  has_many :vision_tag_relationships, dependent: :destroy
  has_many :posts, through: :vision_tag_relationships

  validates :name, uniqueness: :true

  def self.search(name)
    where("name LIKE?", "#{name}")
  end
end

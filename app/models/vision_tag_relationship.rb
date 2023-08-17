class VisionTagRelationship < ApplicationRecord
  belongs_to :post
  belongs_to :vision_tag
end

class Notification < ApplicationRecord

  default_scope -> { order(created_at: :DESC ) }
  
  belongs_to :post,         optional: true
  belongs_to :post_comment, optional: true
  belongs_to :room,         optional: true
  belongs_to :message,      optional: true

  belongs_to :visiter,      class_name: "Member", foreign_key: "visiter_id", optional: true
  belongs_to :visited,      class_name: "Member", foreign_key: "visited_id", optional: true
end

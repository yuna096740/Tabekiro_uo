class Post < ApplicationRecord

  default_scope          -> { order(updated_at: "DESC") }
  enum open_status:         { open: 0, unopened: 1, during_trade: 2, complete: 3 }
  scope :recentry_posts, -> { where.not(open_status: "unopened").order(updated_at: :desc ).limit(3) }

  belongs_to :member
  belongs_to :tag
  has_many   :post_comments,            dependent: :destroy
  has_many   :favorites,                dependent: :destroy
  has_many   :rooms,                    dependent: :destroy
  has_many   :notifications,            dependent: :destroy
  has_many   :vision_tag_relationships, dependent: :destroy
  has_many   :vision_tags,              through: :vision_tag_relationships

  validates :tag_id,       presence: :true
  validates :post_image,   presence: :true
  validates :longitube,    presence: :true
  validates :latitude,     presence: :true
  validates :title,        presence: :true, length: { in: 1..60 }
  validates :place_name,   presence: :true, length: { in: 1..15 }
  validates :introduction, presence: :true, length: { in: 1..150 }

  has_one_attached :post_image

  # <!---- ActiveStrage method ----!>
  def get_post_image(width, height)
    post_image.variant(resize_to_fill: [width, height]).processed
  end

  # <!---- Favorite method ----!>
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  # <!---- Search method ---!>
  def self.search(keyword)
    where(["title LIKE? or introduction LIKE? or place_name LIKE?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  # <!---- Notification method ----!>
  # Faborite method
  def create_notification_favorite!(current_member)
    myfav = Notification.where(["visiter_id = ? and Visited_id = ? and post_id = ? and action = ?", current_member.id, member_id, id, "favorite"])
    if myfav.blank?
      notice = current_member.active_notifications.new(
        post_id: id,
        visited_id: member_id,
        action: "favorite"
      )
      unless notice.visiter_id == notice.visited_id
        notice.save if notice.valid?
      end
    end
  end

  # PostComment method (create)
  def create_notification_comment!(current_member, post_comment_id)
     # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    others_comment_ids = PostComment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct #distinctする場合は、selectとしてから
    others_comment_ids.each do |comment_id|
      save_notification_comment!(current_member, post_comment_id, comment_id['member_id'])
    end
    save_notification_comment!(current_member, post_comment_id, member_id) if others_comment_ids.blank?
  end

  # PostComment method (save)
  def save_notification_comment!(current_member, post_comment_id, visited_id)
    notice = current_member.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    if notice.visiter_id == notice.visited_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end

  # <!---- Vision_tag method ----!>
  def save_vision_tags(vision_tags)
    vision_tags.each do |new_tags|
      self.vision_tags.find_or_create_by(name: new_tags)
    end
  end

  def update_vision_tags(latest_tags)
    latest_tags.each do |latest_tag|
      self.vision_tags.find_or_create_by(name: latest_tag)
    end

    current_tags = self.vision_tags.pluck(:name)
    old_tags =     current_tags - latest_tags
    new_tags =     latest_tags - current_tags

    old_tags.each do |old_tag|
      vision_tag = self.vision_tags.find_by(name: old_tag)
      self.vision_tags.delete(vision_tag) if vision_tag.present?
    end

    new_tags.each do |new_tag|
      tag = self.vision_tags.find_or_create_by(name: new_tag)
      self.vision_tags << tag
    end
  end
end

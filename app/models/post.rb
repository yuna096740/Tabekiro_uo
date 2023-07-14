class Post < ApplicationRecord

  default_scope ->  { order(created_at: "DESC") }
  enum open_status: { open: 0, unopened: 1,complete: 2 }

  belongs_to :member
  belongs_to :tag
  has_many   :post_comments, dependent: :destroy
  has_many   :favorites,     dependent: :destroy
  has_many   :rooms,         dependent: :destroy
  has_many   :notifications, dependent: :destroy

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

  def create_notification_favorite!(current_member)
    temp = Notification.where(["visiter_id = ? and Visited_id = ? and post_id = ? and action = ?", current_member.id, member_id, id, "favorite"])
    if temp.blank?
      notice = current_member.active_notifications.new(
        post_id: id,
        visited_id: member_id,
        action: "favorite"
      )
      if notice.visiter_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end

  def create_notification_comment!(current_member, post_comment_id)
     # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct #distinctする場合は、selectとしてから
    temp_ids.each do |temp_id|
      save_notification_comment!(current_member, post_comment_id, temp_id['member_id'])
    end
    save_notification_comment!(current_member, post_comment_id, member_id) if temp_ids.blank?
  end

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
end

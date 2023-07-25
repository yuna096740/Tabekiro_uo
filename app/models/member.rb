class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,           presence: :true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :nickname,        presence: :true, length: { in: 1..15 }

  default_scope ->            { order(created_at: "DESC") }
  enum status:                { active: 0, banned: 1, inactive: 2 }
  enum reason_for_quit_genre: { no_chance_to_use: 0, hard_to_use: 1, others: 2 }

  has_many :posts,                 dependent: :destroy
  has_many :post_comments,         dependent: :destroy
  has_many :favorites,             dependent: :destroy
  has_many :messages,              dependent: :destroy
  has_many :entries,               dependent: :destroy
  has_many :rooms,                 through: :entries

  has_many :reports,               class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports,    class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_many :active_notifications,  class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  has_many :subscribes,            class_name: "Relationship", foreign_key: "subscriber_id", dependent: :destroy
  has_many :reverse_of_subscribes, class_name: "Relationship", foreign_key: "subscribed_id", dependent: :destroy
  has_many :subscribings,          through: :subscribes, source: :subscribed
  has_many :subscribers,           through: :reverse_of_subscribes, source: :subscriber

  has_one_attached :icon

  def get_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/no-ion.jpg')
      icon.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    icon.variant(resize_to_fill: [width, height]).processed
  end

  def self.search(keyword)
    where(["nickname LIKE? or email LIKE? or introduction LIKE?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def subscribe(member_id)
    subscribes.create(subscribed_id: member_id)
  end

  def unsubscribe(member_id)
    subscribes.find_by(subscribed_id: member_id).destroy
  end

  def subscribing?(member)
    subscribings.include?(member)
  end

  def create_notification_subscribe!(current_member)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_member.id, id, "subscribe"])
    if temp.blank?
      notice = current_member.active_notifications.new(
        visited_id: id,
        action: "subscribe"
      )
      notice.save if notice.valid?
    end
  end

  GUEST_MEMBER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.nickname = "guestmember"
    end
  end

  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end

  def active_for_authentication?
    super && (status == 'active')
  end
end

class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,         dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :reports,            class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_many :subscribes,            class_name: "Relationship", foreign_key: "subscriber_id", dependent: :destroy
  has_many :reverse_of_subscribes, class_name: "Relationship", foreign_key: "subscribed_id", dependent: :destroy

  has_many :subscribings, through: :subscribes, source: :subscribed
  has_many :subscribers,  through: :reverse_of_subscribes, source: :subscriber

  has_one_attached :icon

  def get_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/no-icon.jpg')
      icon.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    icon.variant(resize_to_fill: [width, height]).processed
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
end

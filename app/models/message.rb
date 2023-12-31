class Message < ApplicationRecord
  has_many   :notifications, dependent: :destroy
  belongs_to :member
  belongs_to :room

  validates :message, presence: :true
end

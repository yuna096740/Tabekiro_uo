class Room < ApplicationRecord

  has_many   :notifications, dependent: :destroy
  has_many   :entries,       dependent: :destroy
  has_many   :messages,      dependent: :destroy
  belongs_to :post

  def create_notification_dm!(current_member, message_id)
    multiple_entry_records = Entry.where(room_id: id).where.not(member_id: current_member.id)
    single_entry_record =    multiple_entry_records.find_by(room_id: id)
    notice = current_member.active_notifications.new(
      room_id: id,
      message_id: message_id,
      visited_id: single_entry_record.member_id,
      action: 'dm'
    )
    notice.save if notice.valid?
  end
end

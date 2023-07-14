module ApplicationHelper
  def unchecked_notifications
    @notifications = current_member.passive_notifications.where(checked: false)
  end
end

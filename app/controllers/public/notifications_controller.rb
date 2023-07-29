class Public::NotificationsController < ApplicationController
  before_action :authenticate_member!

  def destroy
    @notices = current_member.passive_notifications
    Notification.find(params[:id]).destroy
  end

  def destroy_all
    current_member.passive_notifications.destroy_all
    redirect_to request.referer
  end

  def notice
    @notices = current_member.passive_notifications
    @notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
    @unchecked_notice = current_member.passive_notifications.where(checked: false)
  end
end
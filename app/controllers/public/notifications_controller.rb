class Public::NotificationsController < ApplicationController

  def destroy
    @notice = Notification.find(params[:id])
    @notice.destroy
  end

  def destroy_all
    current_member.passive_notifications.destroy_all
    redirect_to request.referer
  end
end

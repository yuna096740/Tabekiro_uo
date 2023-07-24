class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member

  def create
    current_member.subscribe(params[:member_id])
    @member.create_notification_subscribe!(current_member)
  end

  def destroy
    current_member.unsubscribe(params[:member_id])
  end

  def subscribings
    @members = @member.subscribings.page(params[:page]).per(8)
  end

  def subscribers
    @members = @member.subscribers.page(params[:page]).per(8)
  end

  private

  def set_member
    @member = Member.find(params[:member_id])
  end
end

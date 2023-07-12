class Public::RelationshipsController < ApplicationController

  def create
    current_member.subscribe(params[:member_id])
    @member = Member.find(params[:member_id])
    #redirect_to request.referer
  end

  def destroy
    current_member.unsubscribe(params[:member_id])
    @member = Member.find(params[:member_id])
    #redirect_to request.referer
  end

  def subscribings
    @member = Member.find(params[:member_id])
    @members = @member.subscribings
  end

  def subscribers
    @member = Member.find(params[:member_id])
    @members = @member.subscribers
  end
end

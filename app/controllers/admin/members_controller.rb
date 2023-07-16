class Admin::MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @report = Report.where(reported_id: @member.id).count
    #binding.irb
  end

  def update
    Member.find(params[:id]).update(member_params)
    redirect_to request.referer
  end

  private

  def member_params
    params.require(:member).permit(:status)
  end
end

class Admin::MembersController < ApplicationController

  def index
    @members = Member.all.page(params[:page]).per(2)
  end

  def show
    @member = Member.find(params[:id])
    @report_count = Report.where(reported_id: @member.id).count
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

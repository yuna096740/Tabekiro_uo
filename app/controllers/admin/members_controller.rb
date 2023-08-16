class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_member, except: [:index]

  def index
    @members = Member.all.page(params[:page]).per(8)
  end

  def show
    @report_count = Report.where(reported_id: @member.id).count
  end

  def update
    @member.update(member_params)
    redirect_to request.referer, notice: "ステータスを更新しました。"
  end

  private

  def member_params
    params.require(:member).permit(:status)
  end

  def set_member
    @member = Member.find(params[:id])
  end
end

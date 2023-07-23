class Public::ReportsController < ApplicationController
  before_action :authenticate_member!

  def new
    @report = Report.new
    @member = Member.find(params[:member_id])
  end

  def confirm
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_member.id
    @report.reported_id = @member.id
  end

  def create
    @report = Report.new(report_params)
    @report.save
    redirect_to posts_path, notice: "通報が完了しました"
  end

  private

  def report_params
    params.require(:report).permit(:genre, :reason, :reporter_id, :reported_id)
  end
end

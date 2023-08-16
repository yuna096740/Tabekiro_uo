class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_report

  def show
  end

  def update
    @report.update(report_params)
    redirect_to request.referer, notice: "ステータスを更新しました。"
  end

  private

  def report_params
    params.require(:report).permit(:is_supported)
  end

  def set_report
    @report =  Report.find(params[:id])
  end
end

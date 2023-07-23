class Admin::ReportsController < ApplicationController

  def show
    @report =  Report.find(params[:id])
  end

  def update
    Report.find(params[:id]).update(report_params)
    redirect_to request.referer, notice: "ステータスを更新しました。"
  end

  private

  def report_params
    params.require(:report).permit(:is_supported)
  end
end

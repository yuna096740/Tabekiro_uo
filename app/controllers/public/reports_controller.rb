class Public::ReportsController < ApplicationController
  before_action :authenticate_member!
  before_action :valid_id?, only: [:show]

  def new
    @report = Report.new
    @member = Member.find(params[:member_id])
  end

  def confirm
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    if @report.reason.present?
      @report.reporter_id = current_member.id
      @report.reported_id = @member.id
    else
      @report = Report.new
      flash.now[:notice] = "通報内容を入力してください"
      render :new
    end
  end

  def create
    @report = Report.new(report_params)
    @report.save
    redirect_to posts_path, notice: "通報が完了しました"
  end

  def show # リロード対策
  end

  private

  def report_params
    params.require(:report).permit(:genre, :reason, :reporter_id, :reported_id)
  end

  def valid_id?
    if params[:id].to_s == "confirm"
      redirect_to request.referer, notice: "現在のページでのリロードは処理が無効となります。"
      return
    end
  end
end

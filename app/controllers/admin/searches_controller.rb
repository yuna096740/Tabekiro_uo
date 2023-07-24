class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.search(params[:keyword]).page(params[:page]).per(8)
  end

  def show
    @member =  Member.find(params[:id])
    @reports = Report.where(reported_id: @member.id).page(params[:page]).per(8)
  end
end

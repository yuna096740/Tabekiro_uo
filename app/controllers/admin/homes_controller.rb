class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @reports = Report.all.order(created_at: "DESC").page(params[:page]).per(8)
  end
end

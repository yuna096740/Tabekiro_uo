class Admin::HomesController < ApplicationController

  def top
    @reports = Report.all.order(created_at: "DESC").page(params[:page]).per(8)
  end
end

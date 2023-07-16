class Admin::SearchesController < ApplicationController

  def index
    @members = Member.search(params[:keyword])
  end

  def show
    @member =  Member.find(params[:id])
    @reports = Report.where(reported_id: @member.id)
    #binding.irb
  end
end

class Admin::SearchesController < ApplicationController

  def index
    @members = Member.search(params[:keyword])
  end
end

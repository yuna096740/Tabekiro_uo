class Public::TagsController < ApplicationController

  def show
    @tag =   Tag.find(params[:id])
    posts =  @tag.posts.where.not(open_status: "unopened")
    @posts = posts.page(params[:page]).per(24)
  end
end

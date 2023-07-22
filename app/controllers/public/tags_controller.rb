class Public::TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.all.page(params[:page]).per(24)
  end
end

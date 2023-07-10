class Public::TagsController < ApplicationController
  
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.all
  end
end

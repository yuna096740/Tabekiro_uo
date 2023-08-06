class Public::VisionTagsController < ApplicationController

  def show
    @vision_tag = VisionTag.find(params[:id])
    posts = Post.where(id: params[:post_id])
    @posts = posts.page(params[:page]).per(24)
  end
end

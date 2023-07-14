class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_favorite!(current_member)
    #redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end

class Public::FavoritesController < ApplicationController
  before_action :set_post
  def create
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_favorite!(current_member)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end

class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  before_action :set_post

  def create
    favorite = current_member.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_favorite!(current_member)
  end

  def destroy
    favorite = current_member.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end

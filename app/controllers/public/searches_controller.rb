class Public::SearchesController < ApplicationController

  def index
    @posts = Post.search(params[:keyword]).page(params[:page]).per(24)
  end
end

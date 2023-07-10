class Public::SearchesController < ApplicationController

  def index
    @posts = Post.search(params[:keyword])
  end
end

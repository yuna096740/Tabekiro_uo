class Public::PostsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def edit
  end
end

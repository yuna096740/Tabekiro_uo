class Public::HomesController < ApplicationController
  def top
    @posts = Post.recentry_posts
  end

  def about
  end
end

class Public::MembersController < ApplicationController

  def index
    @my_posts = current_member.posts.all.order(created_at: "DESC")
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.all.order(created_at: "DESC")
  end

  def edit
  end
end

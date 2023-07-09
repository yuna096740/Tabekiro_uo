class Public::MembersController < ApplicationController

  def index
    @my_posts = current_member.posts.all.order(created_at: "DESC")
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.all.order(created_at: "DESC")
  end

  def edit
    @member = current_member
  end

  def update
    member = current_member
    member.update(member_params)
    redirect_to members_path(current_member)
  end

  private

  def member_params
    params.require(:member).permit(:nickname,
                                   :email,
                                   :introduction,
                                   :icon
                                  )
  end
end

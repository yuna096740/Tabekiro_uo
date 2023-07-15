class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit]
  def index
    @posts = current_member.posts.all
  end

  def show
    @member = Member.find(params[:id])
    @posts =  @member.posts.all
  end

  def edit
    @member = current_member
  end

  def update
    member = current_member
    member.update(member_params)
    redirect_to members_path(current_member)
  end

  def favorite
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def deal
    @member =  current_member
    @entries = @member.entries.all
    rooms = []
    @posts = []
    @entries.each do |entry|
      rooms.push(Room.find(entry.room_id))
    end
    rooms.each do |room|
      @posts.push(Post.find(room.post_id))
    end
  end

  private

  def member_params
    params.require(:member).permit(:nickname,
                                   :email,
                                   :introduction,
                                   :icon
                                  )
  end

  def ensure_guest_member
    if current_member.guest_member?
      redirect_to member_path(current_member), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end

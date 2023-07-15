class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit]
  before_action :set_current_member,  only: [:edit, :update, :deal, :quit_form, :confirm, :quit]

  def index
    @posts = current_member.posts.all
  end

  def show
    @member = Member.find(params[:id])
    @posts =  @member.posts.all
  end

  def edit
  end

  def update
    @member.update(member_params)
    redirect_to members_path(@member)
  end

  def favorite
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def deal
    @entries = @member.entries.all
    rooms =  []
    @posts = []
    @entries.each do |entry|
      rooms.push(Room.find(entry.room_id))
    end
    rooms.each do |room|
      @posts.push(Post.find(room.post_id))
    end
  end

  def quit_form
  end

  def confirm
    @member = Member.new(
      nickname:              current_member.nickname,
      reason_for_quit_genre: params[:member][:reason_for_quit_genre],
      reason_for_quit:       params[:member][:reason_for_quit]
    )
  end

  def quit
    @member.update(
      status: :inactive,
      reason_for_quit_genre: params[:member][:reason_for_quit_genre],
      reason_for_quit:       params[:member][:reason_for_quit]
    )
    reset_session
    redirect_to root_path
  end

  private

  def member_params
    params.require(:member).permit(:nickname,
                                   :email,
                                   :introduction,
                                   :icon,
                                   :status,
                                   :reason_for_quit_genre,
                                   :reason_for_quit
                                  )
  end

  def ensure_guest_member
    if current_member.guest_member?
      redirect_to member_path(current_member), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def set_current_member
    @member = current_member
  end
end

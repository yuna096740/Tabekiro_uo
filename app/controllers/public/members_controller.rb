class Public::MembersController < ApplicationController

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
    #entrys = Entry.where(member_id: current_member.id)
    #room_ids = []
    #entrys.each do |entry|
     # entries = Room.find(entry.room_id).entries.where.not(member_id: current_member.id)
      #@entries[entry.room_id] = entries
    
    #@deal_posts = Post.where(id: rooms.post_id)
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

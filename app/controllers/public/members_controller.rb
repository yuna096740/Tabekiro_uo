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
  
  def create_notification_subscribe!(current_member)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_member.id, id, "subscribe"])
    if temp.blank?
      notice = current_member.active_notifications.new(
        visited_id: id,
        action: "subscribe"
      )
      notice.save if notice.valid?
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
end

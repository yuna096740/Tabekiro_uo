class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @comment = PostComment.new
    @post =    Post.find(params[:id])

    @member =                 @post.member
    @current_member_entries = Entry.where(member_id: current_member.id)
    @member_entries =         Entry.where(member_id: @member.id)
    @room_ids = [] #配列の宣言
    @entries =  []
    @current_member_entries.each do |cm_entry|
      @member_entries.each do |m_entry|
        if cm_entry.room_id == m_entry.room_id
          if cm_entry.room.post_id == @post.id
            @is_room = true
            @room_ids.push(cm_entry.room_id)#破壊的メソッド、配列の末尾に引数を要素に追加。レシーバーであるオブジェクトを変更できている
            entries = Room.find(cm_entry.room_id).entries.where.not(member_id: current_member.id) #投稿者では無いidを
            @entries[cm_entry.room_id] = entries[0]#インデックス番号を指定
          end
        end
      end
    end
    unless @is_room
      @room =  Room.new
      @entry = Entry.new
    end
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    post = current_member.posts.new(post_params)
    post.save
    redirect_to post_path(post)
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
  end

  def update
    Post.find(params[:id]).update(post_params)
    redirect_to posts_path
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  def map
    @posts = Post.all
  end

  def create_notification_favorite!(current_member)
    temp = Notification.where(["visiter_id = ? and Visited_id = ? and post_id = ? and action = ?", current_member.id, member_id, id, "favorite"])
    if temp.blank?
      notice = current_member.active_notifications.new(
        post_id: id,
        visited_id: member_id,
        action: "favorite"
      )
      if notice.visiter_id == notice.visited_id
        notificcation.checked = true
      end
      notice.save if notice.valid?
    end
  end
  
  def create_notification_comment!(current_member, post_comment_id)
     # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct #distinctする場合は、selectとしてから
    temp_ids.each do |temp_id|
      save_notification_comment!(current_member, post_comment_id, temp_id['member_id'])
    end
    save_notification_comment!(current_member, post_comment_id, member_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_member, post_comment_id, visited_id)
    notice = current_member.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    if notice.visiter_id == notification.visited_id
      notification.checked = true
    end
    notice.save if notice.valid?
  end

  private

  def post_params
    params.require(:post).permit(:tag_id,
                                 :title,
                                 :introduction,
                                 :limit,
                                 :latitude,
                                 :longitube,
                                 :place_name,
                                 :open_status,
                                 :post_image,
                                 :member_id
                                )
  end
end

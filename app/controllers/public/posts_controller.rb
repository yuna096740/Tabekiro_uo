class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @comment = PostComment.new
    @post =    Post.find(params[:id])
    if member_signed_in?
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

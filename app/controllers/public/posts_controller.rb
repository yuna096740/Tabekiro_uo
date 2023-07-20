class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show, :map]
  before_action :set_post,             only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = PostComment.new
    if member_signed_in?
      @member =                 @post.member
      @current_member_entries = Entry.where(member_id: current_member.id)
      @member_entries =         Entry.where(member_id: @member.id)
      @room_ids = []
      @entries =  []
      @current_member_entries.each do |cm_entry|
        @member_entries.each do |m_entry|
          if cm_entry.room_id == m_entry.room_id
            if cm_entry.room.post_id == @post.id
              @is_room = true
              @room_ids.push(cm_entry.room_id)
              entries = Room.find(cm_entry.room_id).entries.where.not(member_id: current_member.id)
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
    @tags = Tag.all
  end

  def update
    Post.find(params[:id]).update(post_params)
    redirect_to post_path(@post)
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

  def set_post
    @post = Post.find(params[:id])
  end
end

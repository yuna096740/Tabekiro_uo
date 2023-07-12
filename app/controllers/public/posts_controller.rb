class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @comment = PostComment.new
    @post = Post.find(params[:id])
    @member = @post.member
    @current_member_entry = Entry.where(member_id: current_member.id)
    @member_entry =         Entry.where(member_id: @member.id)
    unless @member.id == current_member.id
      @current_member_entry.each do |cm|
        @member_entry.each do |m|
          if cm.room_id == m.room_id
            @is_room = true
            @room_id = cm.room_id
          end
        end
      end
      if @is_room
      else
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
                                 :is_open,
                                 :post_image,
                                 :member_id
                                )
  end
end

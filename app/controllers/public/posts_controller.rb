class Public::PostsController < ApplicationController

  before_action :authenticate_member!, except: [:index, :show, :map], unless: :admin_signed_in?
  before_action :set_post,             only: [:show, :edit, :update, :destroy]

  def index
    posts =  Post.where.not(open_status: "unopened")
    @posts = posts.page(params[:page]).per(24)
  end

  def show
    @vision_tags = @post.vision_tags
    @comment =     PostComment.new
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
              @entries[cm_entry.room_id] = entries[0] # インデックス番号を指定
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
    @post = current_member.posts.new(post_params)
    vision_tags = Vision.get_image_data(post_params[:post_image])
    @post.attributes = post_params
    if @post.valid?
      @post.save!
      @post.save_vision_tags(vision_tags)
      redirect_to post_path(@post), notice: "投稿しました。"
    else
      @tags = Tag.all
      render :new
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    ActiveRecord::Base.transaction do
      @post.attributes = post_params
      if @post.valid?
        @post.update(post_params)
        if post_params[:post_image].present?
          vision_tags = Vision.get_image_data(post_params[:post_image])
          @post.update_vision_tags(vision_tags)
        end
        redirect_to post_path(@post), notice: "投稿内容を更新しました。"
      else
        @tags = Tag.all
        render :edit
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
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



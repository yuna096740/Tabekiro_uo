class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
    @comments = @post.post_comments.all
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
                                 :post_image
                                )
  end
end

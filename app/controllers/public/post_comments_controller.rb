class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    ActiveRecord::Base.transaction do
      if @comment.save
        @post.create_notification_comment!(current_member, @comment.id)
      else
        render 'errors'
      end
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
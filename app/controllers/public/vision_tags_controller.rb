class Public::VisionTagsController < ApplicationController

  def show
    @vision_tag = VisionTag.find(params[:id])
    tags = VisionTag.search(@vision_tag.name)
    @posts = tags.map do |tag|
      tag.posts
    end.flatten
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(24)
  end
end

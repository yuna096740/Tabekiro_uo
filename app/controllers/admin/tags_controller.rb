class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all
    @tag  = Tag.new
  end

  def create
    tag = Tag.new(tag_params)
    tag.save
    redirect_to admin_tags_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    Tag.find(params[:id]).update(tag_params)
    redirect_to admin_tags_path
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end

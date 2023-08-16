class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, except: [:index, :create]

  def index
    @tags = Tag.all
    @tag  = Tag.new
  end

  def create
    tag = Tag.new(tag_params)
    tag.save
    redirect_to admin_tags_path, notice: "登録しました。"
  end

  def edit
  end

  def update
    @tag.update(tag_params)
    redirect_to admin_tags_path, notice: "更新しました。"
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path, notice: "削除しました。"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end

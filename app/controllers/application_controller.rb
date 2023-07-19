class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :notice,                         if: :member_signed_in?
  before_action :search_member,                  if: :admin_signed_in?
  before_action :search_post,                    unless: :admin_signed_in?
  before_action :search_tag

  def after_sign_in_path_for(resource)
    if current_member
      flash[:notice] = "おかえりなさい！"
      posts_path
    else
      flash[:notice] = "ようこそ！たべきろ魚へ！自己紹介を完成させて取引してみましょう！"
      members_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :status ])
  end

  def search_tag
    @tags = Tag.all
  end

  def search_post
    @keyword = params[:keyword]
  end

  def search_member
    @keyword = params[:keyword]
  end

  def notice
    notices = current_member.passive_notifications
    notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
    @notices = current_member.passive_notifications.where(checked: false)
  end
end

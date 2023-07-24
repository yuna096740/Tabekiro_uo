class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :after_sign_in_path_for,         if: :member_signed_in?
  before_action :notice,                         if: :member_signed_in?
  before_action :search_member,                  if: :admin_signed_in?
  before_action :search_post,                    unless: :admin_signed_in?
  before_action :search_tag

  protected

  def after_sign_in_path_for(resource)
    posts_path
  end

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
    @notices = current_member.passive_notifications
    @unchecked_notices = current_member.passive_notifications.where(checked: false)
  end
end
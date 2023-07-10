class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_tag
  before_action :search_post

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :status, ])
  end

  def search_tag
    @tags = Tag.all
  end

  def search_post
    @keyword = params[:keyword]
  end
end

# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_invalid_member, only: [:create]

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to member_path(member), notice: "Guestでログインしました。"
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_invalid_member
    member = Member.find_by(email: params[:member][:email])
    return unless member
    return if member.valid_password?(params[:member][:password]) && member.active_for_authentication?
    alert_message = if member.status == 'inactive'
                      "このアカウントは退会済みです。"
                    else
                      "このアカウントは利用停止中です。"
                    end
    redirect_to request.referer, alert: alert_message
  end
end

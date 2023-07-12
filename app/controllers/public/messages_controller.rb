class Public::MessagesController < ApplicationController

  def create
    @messages = Message.where(room_id: params[:message][:room_id])
    if Entry.where(member_id: current_member.id, room_id: params[:message][:room_id]).exists?
      message = Message.create((message_params).merge(member_id: current_member.id))
      message.save
    else
      flash[:notice] = "メッセージ送信に失敗しました。"
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id)
  end
end

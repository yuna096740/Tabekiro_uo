class Public::MessagesController < ApplicationController

  def create
    if Entry.where(member_id: current_member.id, room_id: params[:message][:room_id]).exists?
      @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(member_id: current_member.id))
    else
      flash[:notice] = "メッセージ送信に失敗しました。"
    end
    redirect_to room_path(@message.room_id)
  end
end

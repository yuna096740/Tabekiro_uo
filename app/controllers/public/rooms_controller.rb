class Public::RoomsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_room, only: [:show, :destroy]

  def create
    @room =                 Room.create(room_params)
    @current_member_entry = Entry.create(room_id: @room.id, member_id: current_member.id)
    @member_entry =         Entry.create((entry_params).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    if Entry.where(member_id: current_member.id, room_id: @room.id).exists?
      @new_message =  Message.new
      @messages =     @room.messages
      @member_id =    @room.entries.where.not(member_id: current_member.id).pluck(:member_id)
      @member =       Member.find_by(id: @member_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @room.destroy
    redirect_to posts_path, notice: "取引をキャンセルしました。"
  end

  private

  def room_params
    params.require(:room).permit(:post_id)
  end

  def entry_params
    params.require(:entry).permit(:member_id, :room_id)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end

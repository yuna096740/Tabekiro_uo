class Public::RoomsController < ApplicationController

  def create
    @room =                 Room.create
    @current_member_entry = Entry.create(room_id: @room.id, member_id: current_member.id)
    @member_entry =         Entry.create((room_params).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(member_id: current_member.id, room_id: @room.id).exists?
      @messages =     @room.messages
      @new_message  = Message.new
      @entries  =     @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def room_params
    params.require(:entry).permit(:member_id, :room_id)
  end
end

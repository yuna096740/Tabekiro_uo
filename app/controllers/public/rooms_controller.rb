class Public::RoomsController < ApplicationController

  def create
    @room =                 Room.create(room_params)
    @current_member_entry = Entry.create(room_id: @room.id, member_id: current_member.id)
    @member_entry =         Entry.create((entry_params).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(member_id: current_member.id, room_id: @room.id).exists?
      @messages =     @room.messages
      @new_message  = Message.new
      @member_id =    @room.entries.where.not(member_id: current_member.id).pluck(:member_id)
      @member =       Member.find_by(id: @member_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def room_params
    params.require(:room).permit(:post_id)
  end

  def entry_params
    params.require(:entry).permit(:member_id, :room_id)
  end

end

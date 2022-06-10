class Public::ChatsController < ApplicationController
  
  def room
    @chats = Chat.all
    @group = Group.find(params[:group_id])
  end
  
  def create
    @chat.save
    render "room"
  end
  
  def destroy
  end
end

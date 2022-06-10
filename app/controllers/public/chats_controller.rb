class Public::ChatsController < ApplicationController
  
  def room
    @chats = Chat.all
    @group = Group.find(params[:group_id])
  end
  
  def create
    # group = Group.find(params[:group_id])
    # @chat.groud_id = group.id
    # @chat.save
  end
  
  def destroy
  end
end

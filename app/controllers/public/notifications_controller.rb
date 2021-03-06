class Public::NotificationsController < ApplicationController
  
  # def notification
  #   @comment = nil
  #   visiter = link_to notification.visiter.screen_name, notification.visiter, style:"font-weight: bold;"
  #   your_post = link_to "あなたの投稿", notification.article, style:"font-weight: bold;", remote: true
  #   case notification.action
  #     when "follow" then
  #       "#{visiter}があなたをフォローしました"
  #     when "like" then
  #       "#{visiter}が#{your_post}にいいね！しました"
  #     when "comment" then
  #       @comment=Comment.find_by(id:notification.comment_id)&.content
  #       "#{visiter}が#{your_post}にコメントしました"
  #   end
  # end
  
  def index
    @notifications = current_user.passive_notifications.all
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    # binding.irb
  end
  
end

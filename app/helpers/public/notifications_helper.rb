module Public::NotificationsHelper
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
  # def notifications_form(notifications)
  #   article = notifications.article
  #   your_post = link_to "あなたの投稿", @notifications.article, remote: true
  #   case notification.action
  #   when "comment"
  #     "があなたの投稿にコメントをしました#{time_ago_in_words(notification.created_at)}前)"
  #   when "like"
  #     "が#{your_post}にいいね!しました#{time_ago_in_words(notification.created_at)}前)"
  #   when "follow"
  #     "があなたをフォローしました#{time_ago_in_words(notification.created_at)}前)"
  #   else
  #     何かアクションをした
  #   end

  # end
  
end

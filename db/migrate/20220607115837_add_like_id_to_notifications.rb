class AddLikeIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :like_id, :integer
  end
end

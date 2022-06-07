class ChangeColumnNotifications < ActiveRecord::Migration[6.1]
  def change
    change_column_null :notifications, :article_id, true
    change_column_null :notifications, :comment_id, true
  end
end

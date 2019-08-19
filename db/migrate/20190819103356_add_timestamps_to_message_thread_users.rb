class AddTimestampsToMessageThreadUsers < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :message_thread_users, null: false
  end
end

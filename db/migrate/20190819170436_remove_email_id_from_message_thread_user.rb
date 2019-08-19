class RemoveEmailIdFromMessageThreadUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :message_thread_users, :email_id
  end
end

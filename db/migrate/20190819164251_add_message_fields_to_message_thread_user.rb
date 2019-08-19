class AddMessageFieldsToMessageThreadUser < ActiveRecord::Migration[5.2]
  def change
    add_column :message_thread_users, :message_id, :integer
    add_column :message_thread_users, :message_type, :string
  end
end

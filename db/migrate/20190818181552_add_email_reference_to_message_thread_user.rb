class AddEmailReferenceToMessageThreadUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :message_thread_users, :email, foreign_key: true
  end
end

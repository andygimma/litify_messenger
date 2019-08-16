class AddMessageThreadRefToEmails < ActiveRecord::Migration[5.2]
  def change
    add_reference :emails, :message_thread, foreign_key: true
  end
end

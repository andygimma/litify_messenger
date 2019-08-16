class CreateMessageThreadUser < ActiveRecord::Migration[5.2]
  def change
    create_table :message_thread_users do |t|
      t.references :user, foreign_key: true
      t.references :message_thread, foreign_key: true
      t.references :sent_by_user, foreign_key: { to_table: :users }
    end
  end
end

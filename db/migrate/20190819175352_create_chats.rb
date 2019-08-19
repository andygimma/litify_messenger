class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true, add_index: true
      t.references :message_thread, foreign_key: true, add_index: true
      t.text :body, null: false

      t.timestamps
    end
  end
end

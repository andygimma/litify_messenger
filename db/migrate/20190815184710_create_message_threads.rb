class CreateMessageThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :message_threads do |t|
      t.belongs_to :user, foreign_key: true
    end
  end
end

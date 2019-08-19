class AddTimestampsToMessageThreads < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :message_threads, null: false
  end
end

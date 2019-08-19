class MessageThreadUser < ApplicationRecord
  belongs_to :user
  belongs_to :message_thread
  belongs_to :email

  validates_presence_of :user_id
  validates_presence_of :message_thread_id
  validates_presence_of :email_id
end

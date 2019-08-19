class MessageThread < ApplicationRecord
  belongs_to :user
  has_many :emails
  has_many :message_thread_users
  validates_presence_of :user_id
end

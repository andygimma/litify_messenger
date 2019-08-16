class MessageThread < ApplicationRecord
  belongs_to :user
  has_many :emails
  has_many :message_thread_users
end

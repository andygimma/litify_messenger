class Email < ApplicationRecord
  belongs_to :user
  belongs_to :message_thread
  has_one :message_thread_user

  validates_presence_of :subject
  validates_presence_of :body
end

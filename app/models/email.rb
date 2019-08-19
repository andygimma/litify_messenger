class Email < ApplicationRecord
  belongs_to :user
  belongs_to :message_thread

  validates_presence_of :subject
  validates_presence_of :body
end

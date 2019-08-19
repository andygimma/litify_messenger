class MessageThreadUser < ApplicationRecord
  belongs_to :user
  belongs_to :message_thread
  belongs_to :email

  validates_presence_of :user_id
  validates_presence_of :message_thread_id
  validates_presence_of :email_id

  scope :user_dashboard_list, ->(user) { 
    where(user_id: user.id)
    .order('message_thread_users.message_thread_id, created_at DESC')
    .select('DISTINCT ON ("message_thread_id") *')
    .reverse_order
  }
end

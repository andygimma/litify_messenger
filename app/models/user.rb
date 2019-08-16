class User < ApplicationRecord
  include Clearance::User
  has_many :emails
  has_many :message_threads
  has_many :message_thread_users
  validates_presence_of :email
end

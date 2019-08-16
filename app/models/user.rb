class User < ApplicationRecord
  include Clearance::User
  has_many :emails
  has_many :message_threads

  validates_presence_of :email
end

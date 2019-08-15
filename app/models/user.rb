class User < ApplicationRecord
  include Clearance::User
  has_many :emails

  validates_presence_of :email
end

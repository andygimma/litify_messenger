class Email < ApplicationRecord
  belongs_to :user

  validates_presence_of :subject
  validates_presence_of :body
  validates_presence_of :read
end

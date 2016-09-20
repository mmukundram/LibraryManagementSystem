class User < ApplicationRecord
  has_many :bookings
  validates :email, :password, :name, presence: true
end

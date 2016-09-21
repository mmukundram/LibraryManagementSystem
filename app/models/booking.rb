class Booking < ApplicationRecord
  belongs_to :room, :user
  validates :email, :start, presence: true
end

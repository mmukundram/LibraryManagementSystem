class Room < ApplicationRecord
  has_many :bookings
  validates :building, :size, presence: true
  validates :number, presence: true, numericality: {only_integer: true}, uniqueness: true
end

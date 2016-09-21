class Room < ApplicationRecord
  has_many :bookings
  attr_accessor :sizetext
  validates :building, :size, presence: true
  validates :number, presence: true, numericality: {only_integer: true}, uniqueness: true
end

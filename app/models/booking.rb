class Booking < ApplicationRecord
  belongs_to :user, :room
end

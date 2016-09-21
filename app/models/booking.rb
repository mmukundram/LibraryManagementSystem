class Booking < ApplicationRecord
  belongs_to :room, :user
end

class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :email
      t.integer :room
      t.datetime :start
      t.datetime :end
      t.text :team

      t.timestamps
    end
  end
end

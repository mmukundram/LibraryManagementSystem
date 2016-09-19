class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :number
      t.integer :building
      t.integer :size

      t.timestamps
    end
    add_index :rooms, :number, unique: true
  end
end

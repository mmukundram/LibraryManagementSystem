class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
      t.text :address
      t.text :phone
      t.boolean :admin
      t.boolean :removable
      t.boolean :privilege

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

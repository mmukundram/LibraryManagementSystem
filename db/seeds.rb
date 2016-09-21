# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.new({email: 'admin@lib.com', name: 'admin', password_digest: BCrypt::Password.create("admin"),
                  address: 'admin', phone: '0123456789', admin: true, removable: false, privilege: true})
admin.save!
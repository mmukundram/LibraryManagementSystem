# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    * Ruby version 2.2.4
    * Rails version >= 5.0.0.1

* Database creation
    * Table Spec
        * Users
            * email (unique)
            * name
            * password
            * admin (true, false)
            * removable (true, false)
            * privilege (true, false)
        * Bookings
            * email
            * start
            * end
            * team (multivalue text)
        * Rooms
            * number (unique)
            * building (0=Hill, 1=Hunt)
            * size (4, 6, 12)
            
* Initial resource creation
    * Generate scripts
        * Users
            * bin\rails generate scaffold User email:string:uniq name:string password:string address:text phone:text admin:boolean removable:boolean privilege:boolean
        * Bookings
            * bin\rails generate scaffold Booking email:string room:integer start:datetime end:datetime team:text
        * Rooms
            * bin\rails generate scaffold Room number:integer:uniq building:string size:integer
    * Setup DB
        * bin\rails db:setup
        * bin\rails db:migrate
        * bin\rails db:seed

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

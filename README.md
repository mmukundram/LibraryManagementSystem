# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    * Ruby version 2.2.4
    * Rails version >= 5.0.0.1

* System dependencies

* Configuration

* Database creation
    * Table Spec
        * Users
            * email (unique)
            * name
            * password
            * type (0=sysadmin, 1=normal)
            * removable (Y, N)
            * privileged (Y, N)
        * Bookings
            * email
            * start
            * end
            * team (multivalue text)
        * Rooms
            * number (unique)
            * building (0=Hill, 1=Hunt)
            * size (4, 6, 12)
    * Table generate scripts
        * Users
            * bin\rails generate model User email:string:uniq name:string password:string type:integer removable:boolean privilege:boolean
        * Bookings
            * bin\rails generate model Booking email:string start:datetime end:datetime team:text
        * Rooms
            * bin\rails generate model Room number:integer:uniq building:integer size:integer

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

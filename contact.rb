#!/usr/bin/env ruby
gem 'activerecord', '=4.2.7'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')
=begin
When you define a field, you need to provide the name of the column as a symbol,
and then the data type the field will store. :string should be straightforward, but
:text maybe not so much. Basically you can store more characters in a
 :text field than a :string field,which is limited to 256 characters.
 (You might want to write an extensive file on each contact!)
=end

# require 'pry'
class Contact < ActiveRecord::Base
  field :first_name, as: :string
  field :last_name,  as: :string
  field :email,      as: :string
  field :note,       as: :text


  def full_name(fist_name, last_name)
      return "#{first_name} #{last_name}"
  end
end
Contact.auto_upgrade! #This one takes care of effecting any changes to the underlying structure of the tables or columns
# at_exit do
#   ActiveRecord::Base.connection.close
# end
=begin
Ensuring the database connection is closed
By default, SQLite allows 5 concurrent connections. Unfortunately,
there won't be any connections left and you'll get a mysterious Timeout error.
=end

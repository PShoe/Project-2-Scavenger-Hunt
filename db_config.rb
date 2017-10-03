require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'treasurehunt'
}

ActiveRecord::Base.establish_connection(options)

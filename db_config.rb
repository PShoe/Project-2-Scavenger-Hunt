require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'bucketlist'
}

ActiveRecord::Base.establish_connection(options)

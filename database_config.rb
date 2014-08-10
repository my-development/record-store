require 'rubygems'
require 'active_record'
require 'mysql'

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "127.0.0.1",
  :database => "record_store",
  :username => "root",
  :password => ""
)
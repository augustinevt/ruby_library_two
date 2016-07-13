require('book')
require('capybara/rspec')
require('./app.rb')
require('patron')
require('checkout')
require('rspec')
require('launchy')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'library_test'})

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM checkouts *;")
  end
end

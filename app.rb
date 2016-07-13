require('sinatra')
require('sinatra/reloader')
require('./lib/book.rb')
require('./lib/checkout.rb')
require('./lib/patron.rb')
require('pg')
also_reload('./lib/**/*.rb')

DB = PG.connect({:dbname => 'library_test'})

get('/books') do
  @books = Book.all()
  erb(:books)
end

post ('/books') do
  Book.new({title: params[:title], author_last: params[:author_last], author_first: params[:author_first], genre: params[:genre]}).save()
  @books = Book.all()
  erb(:books)
end

get('/book/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end

patch ('/book/:id') do
  @book = Book.find(params[:id].to_i())
  @book.update({title: params[:title], author_last: params[:author_last], author_first: params[:author_first], genre: params[:genre]})
  @book = Book.find(params[:id].to_i())
  redirect "book/#{@book.id()}"
end

delete ('/book/:id') do
  @book = Book.find(params[:id].to_i())
  @book.delete()
  @books = Book.all()
  erb(:books)
end

get('/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

post ('/patrons') do
  Patron.new({patron_last: params[:patron_last], patron_first: params[:patron_first], phone: params[:phone]}).save()
  @patrons = Patron.all()
  erb(:patrons)
end

get('/patron/:id') do
  @patron = Patron.find(params[:id].to_i())
  erb(:patron)
end

patch ('/patron/:id') do
  @patron = Patron.find(params[:id].to_i())
  @patron.update({patron_last: params[:patron_last], patron_first: params[:patron_first], phone: params[:phone]})
  @patron = Patron.find(params[:id].to_i())
  redirect "patron/#{@patron.id()}"
end

delete ('/patron/:id') do
  @patron = Patron.find(params[:id].to_i())
  @patron.delete()
  @patrons = Patron.all()
  erb(:patrons)
end

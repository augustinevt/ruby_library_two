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

require('sinatra')
require('sinatra/reloader')
require('./lib/book.rb')
require('./lib/checkout.rb')
require('./lib/patron.rb')
require('pg')
require('pry')
also_reload('./lib/**/*.rb')

DB = PG.connect({:dbname => 'library_test'})

enable :sessions

get ('/') do
  erb(:index)
end

get('/patron/:patron_id/books') do
  @patron = Patron.find(params['patron_id'].to_i)
  @patron_id = @patron.id()
  @books = Book.all()
  erb(:books)
end

post ('/patron/:patron_id/books') do
  @patron = Patron.find(params['patron_id'].to_i)
  @patron_id = @patron.id()
  Book.new({title: params[:title], author_last: params[:author_last], author_first: params[:author_first], genre: params[:genre]}).save()
  @books = Book.all()
  erb(:books)
end

get('/patron/:patron_id/book/:id') do
  @patron = Patron.find(params['patron_id'].to_i)
  @patrons = Patron.all()
  @book = Book.find(params[:id].to_i())
  erb(:book)
end

patch ('/patron/:patron_id/book/:id') do
  @patron = Patron.find(params['patron_id'].to_i)
  @book = Book.find(params[:id].to_i())
  @book.update({title: params[:title], author_last: params[:author_last], author_first: params[:author_first], genre: params[:genre]})
  @book = Book.find(params[:id].to_i())
  redirect "/patron/#{@patron.id}/book/#{@book.id()}"
end

delete ('/patron/:patron_id/book/:id') do
  @patron = Patron.find(params['patron_id'].to_i)
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

get('/patron/:patron_id') do
  @session = session
  @patron = Patron.find(params['patron_id'].to_i())
  @books =  Checkout.find_books_by_patron(@patron.id())
  erb(:patron)

end

post('/patron/:patron_id') do
  @patron = Patron.find(params['patron_id'].to_i())
  @checkout = Checkout.new({:book_id => params[:book_id], :patron_id => params['patron_id'] })
  @checkout.save()
  @books =  Checkout.find_books_by_patron(@patron.id())
  erb(:patron)

end

patch ('/patron/:patron_id') do
  @patron = Patron.find(params['patron_id'].to_i())
  @patron.update({patron_last: params[:patron_last], patron_first: params[:patron_first], phone: params[:phone]})
  @patron = Patron.find(params['patron_id'].to_i())
  redirect "patron/#{@patron.id()}"
end

delete ('/patron/:patron_id') do
  @patron = Patron.find(params['patron_id'].to_i())
  @patron.delete()
  @patrons = Patron.all()
  erb(:patrons)
end

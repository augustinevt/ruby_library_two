class Checkout

  attr_accessor :patron_id, :book_id, :return_due, :checkout_date, :id

  def initialize(attributes)
    @patron_id = attributes[:patron_id]
    @book_id = attributes[:book_id]
    @return_due = Time.now + 60 * 60 * 24
    @checkout_date = Time.now()
    @id = attributes[:id]
  end

  def save()
    result = DB.exec("INSERT INTO checkouts (patron_id, book_id, return_due, checkout_date) VALUES ('#{@patron_id}', '#{@book_id}', '#{@return_due}', '#{@checkout_date}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  def self.all()
    checkouts = []
    results = DB.exec("SELECT * FROM checkouts;")
    results.each() do |result|
      patron_id = result['patron_id'].to_i
      book_id = result['book_id'].to_i
      return_due = result['return_due']
      checkout_date = result['checkout_date']
      id = result['id'].to_i
      checkout = Checkout.new({patron_id: patron_id, book_id: book_id, return_due: return_due, id: id, checkout_date: checkout_date})
      checkouts.push(checkout)
    end
    checkouts
  end

  def ==(other_checkout)
    self.patron_id() == other_checkout.patron_id() && self.id() == other_checkout.id()
  end

  def self.find(id)
    db_return = DB.exec("SELECT * FROM checkouts WHERE id = #{id};").first
    patron_id = db_return['patron_id'].to_i
    book_id = db_return['book_id'].to_i
    return_due = db_return['return_due']
    checkout_date = db_return['checkout_date']
    id = db_return['id'].to_i
    patron = Checkout.new({patron_id: patron_id, book_id: book_id, return_due: return_due, id: id, checkout_date: checkout_date})
  end


  def update(attributes)
    attributes.each do |col_name, value|
      DB.exec("UPDATE checkouts SET #{col_name} = '#{value}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE id = #{@id}")
  end

  def self.find_books_by_patron(patron_id)
    checkouts = DB.exec("SELECT * FROM checkouts WHERE patron_id = #{patron_id};")
    books = []
    checkouts.each do |checkout|
      id_of_book = checkout['book_id'].to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{id_of_book};").first
      title = book['title']
      author_last = book['author_last']
      author_first = book['author_first']
      genre = book['genre']
      id = book['id'].to_i
      book = Book.new({title: title, author_last: author_last, author_first: author_first, genre: genre, id: id})
      books.push(book)
    end
    books
  end

  def overdue?()
     self.return_due < Time.now
  end
end

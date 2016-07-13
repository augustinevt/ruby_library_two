class Book

  attr_accessor :title, :author_last, :author_first, :genre, :id

  def initialize(attributes)
    @title = attributes[:title]
    @author_last = attributes[:author_last]
    @author_first = attributes[:author_first]
    @genre = attributes[:genre]
    @id = attributes[:id]
  end

  def save()
    result = DB.exec("INSERT INTO books (title, author_last, author_first, genre) VALUES ('#{@title}', '#{@author_last}', '#{@author_first}', '#{@genre}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  def self.all()
    books = []
    results = DB.exec("SELECT * FROM books;")
    results.each() do |result|
      title = result['title']
      author_last = result['author_last']
      author_first = result['author_first']
      genre = result['genre']
      id = result['id'].to_i
      book = Book.new({title: title, author_last: author_last, author_first: author_first, genre: genre, id: id})
      books.push(book)
    end
    books
  end

  def ==(other_book)
    self.title() == other_book.title() && self.id() == other_book.id()
  end

  def self.find(id)
    db_return = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    title = db_return['title']
    author_last = db_return['author_last']
    author_first = db_return['author_first']
    genre = db_return['genre']
    id = db_return['id'].to_i
    book = Book.new({title: title, author_last: author_last, author_first: author_first, genre: genre, id: id})
  end


  def update(attributes)
    attributes.each do |col_name, value|
      DB.exec("UPDATE books SET #{col_name} = '#{value}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{@id}")
  end
end

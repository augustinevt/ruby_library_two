class Checkout

  attr_accessor :patron_id, :book_id, :return_due, :id

  def initialize(attributes)
    @patron_id = attributes[:patron_id]
    @book_id = attributes[:book_id]
    @return_due = attributes[:return_due]
    @id = attributes[:id]
  end

  def save()
    result = DB.exec("INSERT INTO checkouts (patron_id, book_id, return_due) VALUES ('#{@patron_id}', '#{@book_id}', '#{@return_due}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  def self.all()
    checkouts = []
    results = DB.exec("SELECT * FROM checkouts;")
    results.each() do |result|
      patron_id = result['patron_id'].to_i
      book_id = result['book_id'].to_i
      return_due = result['return_due']
      id = result['id'].to_i
      checkout = Checkout.new({patron_id: patron_id, book_id: book_id, return_due: return_due, id: id})
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
    id = db_return['id'].to_i
    patron = Checkout.new({patron_id: patron_id, book_id: book_id, return_due: return_due, id: id})
  end


  def update(attributes)
    attributes.each do |col_name, value|
      DB.exec("UPDATE checkouts SET #{col_name} = '#{value}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE id = #{@id}")
  end
end

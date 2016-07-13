class Patron

  attr_accessor :patron_last, :patron_first, :phone, :id

  def initialize(attributes)
    @patron_last = attributes[:patron_last]
    @patron_first = attributes[:patron_first]
    @phone = attributes[:phone]
    @id = attributes[:id]
  end

  def save()
    result = DB.exec("INSERT INTO patrons (patron_last, patron_first, phone) VALUES ('#{@patron_last}', '#{@patron_first}', '#{@phone}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  def self.all()
    patrons = []
    results = DB.exec("SELECT * FROM patrons;")
    results.each() do |result|
      patron_last = result['patron_last']
      patron_first = result['patron_first']
      phone = result['phone']
      id = result['id'].to_i
      patron = Patron.new({patron_last: patron_last, patron_first: patron_first, phone: phone, id: id})
      patrons.push(patron)
    end
    patrons
  end

  def ==(other_patron)
    self.patron_last() == other_patron.patron_last() && self.id() == other_patron.id()
  end

  def self.find(id)
    db_return = DB.exec("SELECT * FROM patrons WHERE id = #{id};").first
    patron_last = db_return['patron_last']
    patron_first = db_return['patron_first']
    phone = db_return['phone']
    id = db_return['id'].to_i
    patron = Patron.new({patron_last: patron_last, patron_first: patron_first, phone: phone, id: id})
  end


  def update(attributes)
    attributes.each do |col_name, value|
      DB.exec("UPDATE patrons SET #{col_name} = '#{value}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{@id}")
  end
end

require 'spec_helper'

describe 'Checkout' do

  describe '#save' do
    it 'should save checkout to database' do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})
      new_checkout.save()
      expect(Checkout.all()).to eq([new_checkout])
    end
  end

  describe '.find' do
    it "finds a checkout by its ID" do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})
      new_checkout.save()
      expect(Checkout.find(new_checkout.id())).to eq(new_checkout)
    end
  end

  describe '#update' do
    it 'should update a checkout attributes' do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})
      new_checkout.save()
      new_checkout.patron_id = 3
      new_checkout.return_due = '1967-04-04'
      new_checkout.checkout_date = '1967-04-03'
      new_checkout.update({patron_id: 3, return_due: '1967-04-04', checkout_date: '1967-04-03'})
      expect(Checkout.find(new_checkout.id())).to eq(new_checkout)
    end
  end

  describe ('#delete') do
    it('should delete a checkout from the database') do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})
      new_checkout.save()
      new_checkout.delete()
      expect(Checkout.all()).to(eq([]))
    end
  end

  describe ('#find_books_by_patron') do
    it('should delete a checkout from the database') do

      new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '123-456-7890', id: nil})
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book2 = Book.new({title: 'The Moon Also Rises', author_last: 'Hemingway', author_first: 'Bernie', genre: 'non-fiction', id: nil})

      new_patron.save()
      new_book.save()
      new_book2.save()

      new_checkout = Checkout.new({patron_id: new_patron.id(), book_id: new_book.id(), return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})
      new_checkout2 = Checkout.new({patron_id: new_patron.id(), book_id: new_book2.id(), return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})

      new_checkout.save()
      new_checkout2.save()

      expect(Checkout.find_books_by_patron(new_patron.id())).to(eq([new_book, new_book2]))
    end
  end

  describe ('#overdue?') do
    it('should returns true if book is overdue') do
      new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '123-456-7890', id: nil})
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book2 = Book.new({title: 'The Moon Also Rises', author_last: 'Hemingway', author_first: 'Bernie', genre: 'non-fiction', id: nil})

      new_patron.save()
      new_book.save()
      new_book2.save()

      new_checkout = Checkout.new({patron_id: new_patron.id(), book_id: new_book.id(), return_due: '1992-02-15', checkout_date: '1992-02-14', id: nil})

      new_checkout.save()


      new_checkout.update({ return_due: Time.now() - 60 * 60 * 24 })

      expect(Checkout.find(new_checkout.id()).overdue?()).to(eq(false))
    end
  end




end

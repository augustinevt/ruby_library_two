require 'spec_helper'

describe 'Book' do

  describe '#save' do
    it 'should save book to library' do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      expect(Book.all()).to eq([new_book])
    end
  end

  describe '.find' do
    it "finds a book by its ID" do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      expect(Book.find(new_book.id())).to eq(new_book)
    end
  end

  describe '#update' do
    it 'should update a books attributes' do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      new_book.author_first = 'flippant'
      new_book.genre = 'non-fiction'
      new_book.update({author_first: 'flippant', genre: 'non-fiction'})
      expect(Book.find(new_book.id())).to eq(new_book)
    end
  end

  describe ('#delete') do
    it('should delete a book from the library') do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      new_book.delete()
      expect(Book.all()).to(eq([]))
    end
  end

  describe ('#find_by_title') do
    it('should find a book from the library by its title') do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      expect(Book.find_by_title('The Sun Also Rises')).to(eq(new_book))
    end
  end

end

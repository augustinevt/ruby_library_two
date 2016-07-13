require 'spec_helper'

describe('books resource', {:type => :feature}) do
    it 'should see books when on /books' do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      visit('/books')
      expect(page).to have_content('The Sun Also Rises')
    end

    it 'should see a books when on /book:id' do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      visit('/books')
      click_link('The Sun Also Rises')
      expect(page).to have_content('The Sun Also Rises')
    end

    it 'should add a book' do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      visit('/books')
      fill_in('title', with: 'Emma')
      fill_in('author_last', with: 'Austin')
      fill_in('author_first', with: 'Jane')
      fill_in('genre', with: 'fiction')
      click_button('Add Book')
      expect(page).to have_content('Emma')
    end

    it 'should see an updated book when on /book:id' do
      new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
      new_book.save()
      visit('/books')
      click_link('The Sun Also Rises')
      fill_in('title', with: 'Emma')
      fill_in('author_last', with: 'Austin')
      fill_in('author_first', with: 'Jane')
      fill_in('genre', with: 'fiction')
      click_button('Add Book')
      expect(page).to have_content('Emma')
    end
end

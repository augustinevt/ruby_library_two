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
    click_button('Update Book')
    expect(page).to have_content('Emma')
  end

  it 'should delete book' do
    new_book = Book.new({title: 'The Sun Also Rises', author_last: 'Hemingway', author_first: 'Ernest', genre: 'fiction', id: nil})
    new_book.save()
    visit('/books')
    click_link('The Sun Also Rises')
    click_button('Delete Book')
    expect(page).to_not have_content('The Sun Also Rises')
  end
end

describe('patrons resource', {:type => :feature}) do
  it 'should see patrons when on /patrons' do
    new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '987-867-5309', id: nil})
    new_patron.save()
    visit('/patrons')
    expect(page).to have_content('John Smith')
  end

  it 'should see a patrons when on /patron:id' do
    new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '987-867-5309', id: nil})
    new_patron.save()
    visit('/patrons')
    click_link('John Smith')
    expect(page).to have_content('John Smith')
  end

  it 'should add a patron' do
    new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '987-867-5309', id: nil})
    new_patron.save()
    visit('/patrons')
    fill_in('patron_last', with: 'Smith')
    fill_in('patron_first', with: 'John')
    fill_in('phone', with: '987-867-5309')
    click_button('Add Patron')
    expect(page).to have_content('John Smith')
  end

  it 'should see an updated patron when on /patron:id' do
    new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '987-867-5309', id: nil})
    new_patron.save()
    visit('/patrons')
    click_link('John Smith')
    fill_in('patron_last', with: 'Jones')
    fill_in('patron_first', with: 'Will')
    fill_in('phone', with: '234-163-6421')
    click_button('Update Patron')
    expect(page).to have_content('Will Jones')
  end

  it 'should delete patron' do
    new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '987-867-5309', id: nil})
    new_patron.save()
    visit('/patrons')
    click_link('John Smith')
    click_button('Delete Patron')
    expect(page).to_not have_content('John Smith')
  end
end

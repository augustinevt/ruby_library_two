require 'spec_helper'

describe 'Patron' do

  describe '#save' do
    it 'should save patron to library' do
      new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '123-456-7890', id: nil})
      new_patron.save()
      expect(Patron.all()).to eq([new_patron])
    end
  end

  describe '.find' do
    it "finds a patron by its ID" do
      new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '123-456-7890', id: nil})
      new_patron.save()
      expect(Patron.find(new_patron.id())).to eq(new_patron)
    end
  end

  describe '#update' do
    it 'should update a patrons attributes' do
      new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '123-456-7890', id: nil})
      new_patron.save()
      new_patron.patron_first = 'flippant'
      new_patron.phone = '980-345-5678'
      new_patron.update({patron_first: 'flippant', phone: '980-345-5678'})
      expect(Patron.find(new_patron.id())).to eq(new_patron)
    end
  end

  describe ('#delete') do
    it('should delete a patron from the library') do
      new_patron = Patron.new({patron_last: 'Smith', patron_first: 'John', phone: '123-456-7890', id: nil})
      new_patron.save()
      new_patron.delete()
      expect(Patron.all()).to(eq([]))
    end
  end

end

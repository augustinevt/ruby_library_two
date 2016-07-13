require 'spec_helper'

describe 'Checkout' do

  describe '#save' do
    it 'should save checkout to database' do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-14', id: nil})
      new_checkout.save()
      expect(Checkout.all()).to eq([new_checkout])
    end
  end

  describe '.find' do
    it "finds a checkout by its ID" do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-14', id: nil})
      new_checkout.save()
      expect(Checkout.find(new_checkout.id())).to eq(new_checkout)
    end
  end

  describe '#update' do
    it 'should update a checkout attributes' do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-14', id: nil})
      new_checkout.save()
      new_checkout.patron_id = 3
      new_checkout.return_due = '1967-04-04'
      new_checkout.update({patron_id: 3, return_due: '1967-04-04'})
      expect(Checkout.find(new_checkout.id())).to eq(new_checkout)
    end
  end

  describe ('#delete') do
    it('should delete a checkout from the database') do
      new_checkout = Checkout.new({patron_id: 1, book_id: 2, return_due: '1992-02-14', id: nil})
      new_checkout.save()
      new_checkout.delete()
      expect(Checkout.all()).to(eq([]))
    end
  end

end

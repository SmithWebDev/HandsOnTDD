require 'rails_helper'

RSpec.describe PageSearch do
  subject { PageSearch }

  describe '.search' do
    it 'nil params returns no pages' do
      expect(subject.search(nil)).to eq([])
    end

    it 'empty params returns no pages' do
      expect(subject.search({})).to eq([])
    end

    it 'an empty term is not sent to .by_term' do
      allow(Page).to receive(:by_term)
      PageSearch.search({ term: '' })
      expect(Page).to_not have_received(:by_term)
    end

    it 'a nil term is not sent to .by_term' do
      allow(Page).to receive(:by_term)
      PageSearch.search({ term: nil })
      expect(Page).to_not have_received(:by_term)
    end

    it 'a valid term is sent to .by_term' do
      allow(Page).to receive(:by_term)
      PageSearch.search({ term: 'foo' })
      expect(Page).to have_received(:by_term).with('foo')
    end
  end
end

require 'rails_helper'

RSpec.describe PageSearch do
  subject { PageSearch }

  describe '.search' do
    it 'nil params returns no pages' do
      expect(subject.search(nil)).to eq([])
    end
  end
end

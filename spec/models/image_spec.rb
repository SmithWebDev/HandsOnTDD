# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'has a valid factory' do
    it { expect(build(:image)).to be_valid }
  end
end

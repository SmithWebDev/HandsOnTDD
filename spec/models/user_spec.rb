# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  # Ensures correct factoy created
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  # Validations group of tests
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }

    it { is_expected.to_not allow_value('foo@').for(:email) }
    it { is_expected.to_not allow_value('@bar.com').for(:email) }
  end
end

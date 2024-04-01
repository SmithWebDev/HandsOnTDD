# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :string
#  name          :string
#  password_hash :string
#  password_salt :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  # Ensures correct factoy created requires a temporary let statement to build
  # the factory Ex. let(:user) { build(:user) }
  # it 'has a valid factory' do
  #   expect(user).to be_valid
  # end

  # Validations group of tests
  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }

    it { is_expected.to allow_value('foo@bar.com').for(:email) }
    it { is_expected.to_not allow_value('foo@').for(:email) }
    it { is_expected.to_not allow_value('@bar.com').for(:email) }
  end

  describe 'set a password' do
    let(:user) { build(:user) }

    it 'sets a password' do
      user.password = 'changeme'
      user.save!

      expect(user.password_salt).to be_present
      expect(user.password_hash).to be_present
    end
  end
end

# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  published  :boolean          default(FALSE), not null
#  slug       :string           not null
#  summary    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pages_on_created_at  (created_at)
#  index_pages_on_published   (published)
#  index_pages_on_slug        (slug) UNIQUE
#  index_pages_on_title       (title) UNIQUE
#  index_pages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page) { build(:page) }

  # Subject can be present with either a build + symbol or just by the model
  # name Ex. subject { page }
  subject { build(:page) }

  # Ensures correct factoy created
  it 'has a valid factory' do
    expect(page).to be_valid
  end

  # Validations group of tests
  describe 'validations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_uniqueness_of :title }
    it { is_expected.to validate_presence_of :content }
  end

  # Slug testing
  describe 'slug' do
    let(:page) { create(:page, title: '--Foo Bar! _ 87 --') }

    it 'is generated from the title' do
      expect(page.slug).to eq('foo-bar-87')
    end
  end
end

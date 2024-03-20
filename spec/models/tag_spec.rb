# == Schema Information
#
# Table name: tags
#
#  id              :bigint           not null, primary key
#  name            :string
#  page_tags_count :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_tags_on_name             (name) UNIQUE
#  index_tags_on_page_tags_count  (page_tags_count)
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:tag) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:page_tags).dependent(:destroy) }
  it { is_expected.to have_many(:tags).through(:page_tags) }
end

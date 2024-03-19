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
  pending "add some examples to (or delete) #{__FILE__}"
end

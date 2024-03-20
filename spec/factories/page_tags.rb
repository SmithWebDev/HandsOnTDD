# == Schema Information
#
# Table name: page_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_page_tags_on_page_id             (page_id)
#  index_page_tags_on_page_id_and_tag_id  (page_id,tag_id) UNIQUE
#  index_page_tags_on_tag_id              (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#  fk_rails_...  (tag_id => tags.id)
#
FactoryBot.define do
  factory :page_tag do
    page { create(:page) }
    tag { create(:tag) }
  end
end

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

RSpec.describe 'Pages' do
  let(:my_page) { create(:page, :published) }

  it 'renders page' do
    visit page_path(slug: my_page.slug)

    article = find('article')

    within article do
      expect(page).to have_css('h2', text: my_page.title)
    end
  end

  describe '#update_tags' do
    let(:page) { create(:page, tags_string: 'foo, bar') }

    context 'when tags do not already exist' do
      it 'creates new tags' do
        expect { page }.to change(Tag, :count).by(2)
        expect(page.tags.map(&:name)).to match_array(%w[foo bar])
      end
    end

    context 'when tags are removed' do
      let(:tag_names) { page.tags.map(&:name) }

      before { page }

      it 'removes tags' do
        page.update(tags_string: 'foo')
        expect(tag_names).to match_array(%w[foo])
      end
    end
  end
end

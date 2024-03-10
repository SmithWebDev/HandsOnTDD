require 'rails_helper'

RSpec.describe 'Search' do
  describe 'Searching' do
    before do
      create(:page, :published, content: 'Page content')
    end

    context 'with no search term' do
      it 'returns no result' do
        visit root_path

        within 'form' do
          fill_in 'term', with: ''
          click_button 'Search'
        end

        expect(page).to have_current_path(search_path(term: ''))
        expect(page).to have_css('p', text: 'No results found')
      end
    end
  end
end

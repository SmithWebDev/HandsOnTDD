require 'rails_helper'

RSpec.describe 'Images' do
  it 'returns an image' do
    create(:image)
    get image_path(Image.last)

    expect(response).to be_successful
    expect(response.content).to eq('image/jpeg')
  end
end

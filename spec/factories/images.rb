# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :image do
    name { 'Name' }

    after(:build) do |image|
      io = Rails.root.join('spec/factories/images/image.jpeg').open
      image.image.attach(io: io,
                         filename: 'image.jpeg',
                         content_type: 'image/jpeg')
    end
  end
end

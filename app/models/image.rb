# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Image < ApplicationRecord
  validates :name, presence: true

  has_one_attached :image
end

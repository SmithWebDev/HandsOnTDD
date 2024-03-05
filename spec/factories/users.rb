# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#
FactoryBot.define do
  factory :user do
    # sequence takes a field 'name' and block that will be called each time a
    # new record is created. The block will be passed a sequential number that
    # will be used to generate unique values.
    sequence(:name) { |n| "First#{n} Last#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end

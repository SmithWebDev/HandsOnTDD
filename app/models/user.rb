# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  email         :string
#  name          :string
#  password_hash :string
#  password_salt :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#
require "bcrypt"

class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@\S+\z/ }

  def password=(password)
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(
      password,
      password_salt
    )
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?

    password_hash = BCrypt::Engine.hash_secret(
      password,
      user.password_salt
    )

    if password_hash == user.password_hash
      user
    end
  end
end

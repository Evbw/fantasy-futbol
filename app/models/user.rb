class User < ActiveRecord::Base
  has_many :teams
  has_many :players, through: :teams
  has_secure_password
  validates :username, uniqueness: true
  validates :email, uniqueness: true
end

class Entity < ApplicationRecord
  has_many :diaries

  validates :username, uniqueness: true
  validates :username, :password, presence: true
end

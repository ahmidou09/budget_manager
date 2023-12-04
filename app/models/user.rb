class User < ApplicationRecord
  has_many :transfers
  has_many :categories

  validates :name, presence: true
end

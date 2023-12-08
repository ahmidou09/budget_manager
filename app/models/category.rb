class Category < ApplicationRecord
  belongs_to :user
  has_many :transfers

  validates :name, presence: true
  validates :icon, presence: true
end

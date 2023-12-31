class Transfer < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :amount, presence: true
  validates :category_id, presence: true
end

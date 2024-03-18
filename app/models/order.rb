class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user, :product, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
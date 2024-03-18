class Product < ApplicationRecord
  belongs_to :user
  belongs_to :vendor
  belongs_to :product_type
  validates :name, :price, presence: true
  has_many :orders
end

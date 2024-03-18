class Vendor < ApplicationRecord
  has_many :products
  validates :name, presence: true
end
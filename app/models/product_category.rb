class ProductCategory < ApplicationRecord
  has_many :product_category_promototions
  has_many :promotions, through: :product_category_promototions
end

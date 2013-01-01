class ProductCategory < ActiveRecord::Base
  belongs_to :category,  touch: true
  belongs_to :product, touch: true
  # attr_accessible :title, :body
end

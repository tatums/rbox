class ProductState < ActiveRecord::Base
  belongs_to :state, touch: true
  belongs_to :product,  touch: true
end

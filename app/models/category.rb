class Category < ActiveRecord::Base
  attr_accessible :active, :title
  has_many :product_categories
  has_many :products, :through => :product_categories

  include Tire::Model::Search
  include Tire::Model::Callbacks

end

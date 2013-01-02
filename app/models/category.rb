class Category < ActiveRecord::Base
  attr_accessible :active, :name
  has_many :product_categories
  has_many :products, :through => :product_categories

  validates :name, :uniqueness => true

  after_update :touch_products

  def touch_products
    products.each{ |p| p.touch }
  end

  include Tire::Model::Search
  include Tire::Model::Callbacks

end

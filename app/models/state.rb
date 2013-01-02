class State < ActiveRecord::Base
  attr_accessible :name
  has_many :product_states
  has_many :products, :through => :product_states

  validates :name, :uniqueness => true

  after_update :touch_products

  def touch_products
    products.each{ |p| p.touch }
  end

  include Tire::Model::Search
  include Tire::Model::Callbacks
end

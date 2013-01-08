class Category < ActiveRecord::Base

  attr_accessible :active, :title, :child, :parent
  has_many :product_categories, :dependent => :destroy
  has_many :products, :through => :product_categories

  extend FriendlyId
  friendly_id :title, use: :slugged
  has_ancestry

  validates :title, :uniqueness => true

  after_update :touch_products

  def touch_products
    products.each{ |p| p.touch }
  end

  include Tire::Model::Search
  include Tire::Model::Callbacks

end

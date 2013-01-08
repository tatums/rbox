class State < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :title
  has_many :product_states, :dependent => :destroy
  has_many :products, :through => :product_states

  validates :title, :uniqueness => true

  after_update :touch_products

  def touch_products
    products.each{ |p| p.touch }
  end

  def states_for_select
    [ title, title.downcase ]
  end

  include Tire::Model::Search
  include Tire::Model::Callbacks
end

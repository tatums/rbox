class Product < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :product_categories
  has_many :categories, :through => :product_categories

  include Tire::Model::Search
  include Tire::Model::Callbacks

  after_touch() { tire.update_index }

  mapping do
    indexes :id,           :index    => :not_analyzed
    indexes :title,        :analyzer => 'snowball', :boost => 100
    indexes :description,  :analyzer => 'snowball'

    indexes :categories do
      indexes :title, analyzer: 'snowball'
    end
    #indexes :published_on, :type => 'date', :include_in_all => false
  end

  def to_indexed_json
    to_json( include: { categories: { only: [:title]} } )
  end


  def self.tire_search(params)
    tire.search(load: true) do
      query { string params[:query]} if params[:query].present?
    end
  end

  #def self.tire_search(params)
    # tire.search(load: true) do
    #   query { string params[:query]} if params[:query].present?
    # end
    # facet "categories" do
    #   terms 'categories.title'
    # end
  #end

  # def self.tire_search(params)
  #   tire.search do
  #     query { string params} if params.present?

  #     facet "categories" do
  #       terms 'categories.title'
  #     end
  #   end
  # end



end

class Product < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :product_categories
  has_many :categories, :through => :product_categories

  has_many :product_states
  has_many :states, :through => :product_states

  include Tire::Model::Search
  include Tire::Model::Callbacks

  after_touch do
    tire.update_index
  end

  mapping do
    indexes :id,           :index    => :not_analyzed
    indexes :title,        :analyzer => 'snowball', :boost => 100
    indexes :description,  :analyzer => 'snowball'

    indexes :categories do
      indexes :name#, analyzer: 'keyword'
    end

    indexes :states do
      indexes :name#, analyzer: 'keyword'
    end
  end

  def to_indexed_json
    to_json( include: {
                        categories: { only: [:name] },
                        states: { only: [:name] }
                      } )
  end


  def self.tire_search(params)
    tire.search(load: true) do
      query { string params[:query]} if params[:query].present?

      facet :categories do
        terms :name
      end

    end

  end


  def self.tsearch(params)
    tire.search(load: true) do
      query {string params}
      facet :categories do
        terms 'categories.name'
      end
      facet :states do
        terms 'states.name'
      end
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

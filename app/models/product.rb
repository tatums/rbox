class Product < ActiveRecord::Base
  attr_accessible :description, :title, :slug, :category_ids, :state_ids

  has_many :product_categories, :dependent => :destroy
  has_many :categories, :through => :product_categories

  has_many :product_states, :dependent => :destroy
  has_many :states, :through => :product_states

  validates_presence_of :title

  include Tire::Model::Search
  include Tire::Model::Callbacks

  after_touch do
    tire.update_index
  end

  mapping do
    indexes :id,           :index    => :not_analyzed
    indexes :title,        :analyzer => 'snowball'
    indexes :description,  :analyzer => 'snowball'

    indexes :categories do
      indexes :slug, analyzer: 'keyword'
    end
    indexes :states do
      indexes :slug, analyzer: 'keyword'
    end
  end

  def to_indexed_json
    to_json(
            include: {
                        categories: { only: [:slug] },
                        states: { only: [:slug] }
                      }
            )
  end


  def self.tire_search(params)
    tire.search :load => { :include => [:categories, :states] } do
      query do
        boolean do
          must { string params[:query] } if params[:query].present?
          params[:states].each { |state| must { term 'states.slug', state } } if params[:states].present?
          params[:categories].each { |category| must { term 'categories.slug', category } } if params[:categories].present?

          params[:not_states].each { |state| must_not { term 'states.slug', state } } if params[:not_states].present?
          params[:not_categories].each { |category| must_not { term 'categories.slug', category } } if params[:not_categories].present?
        end
      end

      facet :categories do
        terms 'categories.slug'
      end

      facet :states do
        terms 'states.slug'
      end
    end
  end

  def category_titles
    categories.map(&:title).join(', ')
  end

  def state_titles
    states.map(&:title).join(', ')
  end

  ##rake environment tire:import CLASS=Category FORCE=true --trace

end

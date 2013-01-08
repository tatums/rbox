require 'active_model'
class Search

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :query, :states, :categories

  def initialize(params={})
    params.each {|key,value| instance_variable_set("@#{key}", value) unless value.nil? }
  end

  def persisted?; end

end
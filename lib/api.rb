module Rbox
  class API < Grape::API

    # http_basic do |username, password|
    #   User.authenticate!(test, pa88word)
    # end

    logger Rails.logger

    version 'v1', using: :header, vendor: 'Rbox'
    format :json

    prefix 'api'

    resource 'products' do

      desc 'index'
      get do
        Product.all
      end

      desc 'show'
      get ':id' do
        Product.find_by_backstage_product_id(params[:id])
      end

      desc 'update'
      put ':id' do
        Product.find_by_backstage_product_id(params[:id]).update_attributes( params.except('id', 'route_info') )
      end

      desc "create"
      post do
        Product.create(params.except('route_info'))
      end

      desc "destroy"
      delete ':id' do

        Product.find_by_backstage_product_id(params[:id]).destroy
      end

    end

  end
end
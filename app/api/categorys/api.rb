module Categorys
  class API < Grape::API
    version 'v1', using: :path
    format :json

    resource :categories do
      desc 'Retrieve all categories'
      get do
        Category.all
      end

      desc 'Create a new category'
      post do
        Category.create!(params)
      end

      desc 'Retrieve a category'
      params do
        requires :id, type: Integer, desc: 'Category ID'
      end
      get ':id' do
        Category.find(params[:id])
      end

      desc 'Delete a category'
      params do
        requires :id, type: Integer, desc: 'Category ID'
      end
      delete ':id' do
        Category.find(params[:id]).destroy
      end
    end
  end
end

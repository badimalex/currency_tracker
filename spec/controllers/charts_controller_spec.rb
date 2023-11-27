require 'rails_helper'

RSpec.describe ChartsController, type: :controller do
  describe 'GET #index' do
    it 'assigns @data' do
      get :index
      expect(assigns(:data)).to include('USD', 'EUR', 'CNY')
    end
  end
end

require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @weekly_rates' do
      get :index
      expect(assigns(:weekly_rates)).to include('USD', 'EUR', 'CNY')
    end
  end
end

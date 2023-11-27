require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  describe '.last_month_rates' do
    let(:currency) { 'USD' }

    before do
      CurrencyRate.create!(currency: currency, nominal: 1, name: 'US Dollar', value: 70, date: 30.days.ago)
      CurrencyRate.create!(currency: currency, nominal: 1, name: 'US Dollar', value: 71, date: Date.today)
    end

    it 'returns rates for the last month for a given currency' do
      rates = CurrencyRate.last_month_rates(currency)
      expect(rates.length).to eq(2)
      expect(rates.first.currency).to eq(currency)
    end
  end
end

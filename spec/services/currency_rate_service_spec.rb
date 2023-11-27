require 'rails_helper'

RSpec.describe CurrencyRateService do
  describe '.weekly_rates' do
    let(:currency) { 'USD' }

    before do
      4.times do |i|
        start_date = i.weeks.ago.beginning_of_week
        end_date = i.weeks.ago.end_of_week
        CurrencyRate.create!(currency: currency, nominal: 1, name: 'US Dollar', value: 70 + i, date: start_date)
        CurrencyRate.create!(currency: currency, nominal: 1, name: 'US Dollar', value: 71 + i, date: end_date)
      end
    end

    it 'calculates weekly rates correctly' do
      rates = described_class.weekly_rates
      expect(rates[currency].length).to eq(4)
      expect(rates[currency].first).to include('₽')
    end
  end
end

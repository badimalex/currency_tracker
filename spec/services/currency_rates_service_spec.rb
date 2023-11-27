require 'rails_helper'

RSpec.describe CurrencyRatesService do
  describe '.fetch_rates' do
    let(:date) { Date.today }
    let(:url) { described_class::URL + date.strftime('%d/%m/%Y') }
    let(:xml_data) { File.read(Rails.root.join('spec/fixtures/cbr_response.xml')) }

    before do
      stub_request(:get, url).to_return(body: xml_data)
    end

    it 'fetches and saves rates correctly' do
      expect { described_class.fetch_rates(date) }.to change { CurrencyRate.count }.by(3)

      rate = CurrencyRate.find_by(currency: 'USD', date: date)
      expect(rate).not_to be_nil
      expect(rate.value).to eq(71.5763)
    end
  end
end

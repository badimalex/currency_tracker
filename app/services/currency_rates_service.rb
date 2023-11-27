require 'net/http'
# require 'nokogiri'

class CurrencyRatesService
  URL = 'https://www.cbr.ru/scripts/XML_daily.asp?date_req='

  REQUIRED_CURRENCIES = ['USD', 'EUR', 'CNY'].freeze

  def self.fetch_rates(date = Date.today)
    url = URI("#{URL}#{date.strftime('%d/%m/%Y')}")
    xml_data = Net::HTTP.get(url)
    save_rates(parse_xml(xml_data), date)
  end

  private

  def self.parse_xml(xml_data)
    doc = Nokogiri::XML(xml_data)
    rates = []
    doc.xpath('//Valute').each do |valute|
      currency = valute.at_xpath('CharCode').text
      next unless REQUIRED_CURRENCIES.include?(currency)

      nominal = valute.at_xpath('Nominal').text.to_i
      name = valute.at_xpath('Name').text
      value = valute.at_xpath('Value').text.gsub(',', '.').to_f
      rates << { currency: currency, nominal: nominal, name: name, value: value }
    end
    rates
  end

  def self.save_rates(rates, date)
    rates.each do |rate_data|
      CurrencyRate.create!(rate_data.merge(date: date))
    end
  end
end

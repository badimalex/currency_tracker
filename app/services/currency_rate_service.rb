class CurrencyRateService
  REQUIRED_CURRENCIES = ['USD', 'EUR', 'CNY'].freeze

  def self.weekly_rates
    rates = {}
    REQUIRED_CURRENCIES.each do |currency|
      rates[currency] = last_four_weeks_rates(currency)
    end
    rates
  end

  private

  def self.last_four_weeks_rates(currency)
    (1..4).map do |weeks_ago|
      start_date = weeks_ago.weeks.ago.beginning_of_week
      end_date = weeks_ago.weeks.ago.end_of_week

      start_rate = find_rate_for_date(currency, start_date)
      end_rate = find_rate_for_date(currency, end_date)

      calculate_rate_change(start_rate, end_rate)
    end
  end

  def self.find_rate_for_date(currency, date)
    CurrencyRate.where(currency: currency, date: date).first
  end

  def self.calculate_rate_change(start_rate, end_rate)
    return 'Данные недоступны' if start_rate.nil? || end_rate.nil?

    start_value = start_rate.value / start_rate.nominal
    end_value = end_rate.value / end_rate.nominal

    change = end_value - start_value
    percentage_change = (change / start_value) * 100

    format_change(percentage_change, start_value)
  end

  def self.format_change(percentage_change, start_value)
    format('%.2f₽ (%+.2f%%)', start_value, percentage_change)
  end
end

class CurrencyRateService
  REQUIRED_CURRENCIES = ['USD', 'EUR', 'CNY'].freeze

  def self.weekly_rates
    rates = {}
    REQUIRED_CURRENCIES.each do |currency|
      rates[currency] = last_four_weeks_rates(currency)
    end
    rates
  end

  def self.last_four_weeks_rates(currency)
    (1..4).map do |weeks_ago|
      start_date = weeks_ago.weeks.ago.beginning_of_week
      end_date = weeks_ago.weeks.ago.end_of_week

      start_rate = CurrencyRate.where(currency: currency, date: start_date).first
      end_rate = CurrencyRate.where(currency: currency, date: end_date).first

      calculate_rate_change(start_rate, end_rate)
    end
  end

  def self.calculate_rate_change(start_rate, end_rate)
    return 'Данные недоступны' if start_rate.nil? || end_rate.nil?

    start_value = start_rate.value / start_rate.nominal
    end_value = end_rate.value / end_rate.nominal

    change = end_value - start_value
    percentage_change = (change / start_value) * 100

    format_change(percentage_change)
  end

  def self.format_change(percentage_change)
    format('%.2f₽ (%+.2f%%)', percentage_change.abs, percentage_change)
  end
end

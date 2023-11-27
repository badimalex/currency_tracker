class CurrencyRate < ApplicationRecord
  def self.last_month_rates(currency)
    where(currency: currency, date: 1.month.ago..Date.today).order(:date)
  end
end

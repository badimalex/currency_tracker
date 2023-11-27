(30.days.ago.to_date..Date.today).each do |date|
  CurrencyRatesService.fetch_rates(date)
end

class RatesController < ApplicationController
  def index
    @weekly_rates = CurrencyRateService.weekly_rates
  end
end

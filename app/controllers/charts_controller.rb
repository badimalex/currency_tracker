class ChartsController < ApplicationController
  def index
    @data ={
      'USD' => CurrencyRate.last_month_rates('USD'),
      'EUR' => CurrencyRate.last_month_rates('EUR'),
      'CNY' => CurrencyRate.last_month_rates('CNY')
    }
  end
end

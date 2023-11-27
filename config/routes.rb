Rails.application.routes.draw do
  get 'charts/index'
  root 'charts#index'

  get 'rates', to: 'rates#index'
end

HeartRateMonitor::Application.routes.draw do
  resources :sessions, only: :show
  root :to => 'sessions#index'
end

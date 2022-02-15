Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get 'produtos/export', to: 'produtos#export'

  devise_for :usuarios
  resources :compras
  resources :pedidos
  resources :produtos
end

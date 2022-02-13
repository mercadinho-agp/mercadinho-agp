Rails.application.routes.draw do
  devise_for :usuarios
  resources :compras
  resources :pedidos
  resources :produtos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end

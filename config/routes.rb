Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :data_files, only: [:create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

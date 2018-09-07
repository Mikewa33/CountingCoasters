Rails.application.routes.draw do
  resources :coaster_model_types
  resources :coaster_companies
  resources :parks
  resources :coaster_models
  resources :model_lines
  resources :companies
  resources :coasters
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

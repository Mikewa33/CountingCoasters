Rails.application.routes.draw do
  resources :coaster_model_types
  resources :coaster_companies
  resources :coaster_models
  resources :model_lines
  resources :companies
  resources :coasters
  resources :parks
  post 'parks/:id/set_visit_count', to: 'parks#set_visit_count'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :members
  resources :groups
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Api => '/'
end

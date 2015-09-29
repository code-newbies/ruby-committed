Rails.application.routes.draw do
  root 'achievements#index'
  resources :achievements
end

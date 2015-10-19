Rails.application.routes.draw do

  devise_for :users, skip: :registrations,
    controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: "users",
      path_names: { new: "sign_up" },
      controller: "devise/registrations",
      as: :user_registration do
        get :cancel
      end
  end
  authenticated :user do
    root "users#show", as: :authenticated_root
  end

  resources :users, only: [:show]
  resources :achievements
  #get 'users/show'
  #get 'users/edit'
  #get 'users/update'

  root 'static_pages#index'
end

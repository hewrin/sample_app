Rails.application.routes.draw do
  get 'password_reset/new'

  get 'password_reset/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  resources :users

  resources :account_activations, only: [:edit]
 
  resources :password_resets, only: [:new, :create, :edit, :update]
end

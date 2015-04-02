Rails.application.routes.draw do
  root 'welcome#index'

  get '/terms' => 'terms#index'
  get '/about' => 'about#index'
  get '/faq' => 'common_questions#index'

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  get 'sign-in', to: 'authentication#new'
  post 'sign-in', to: 'authentication#create'
  get 'sign-out', to: 'authentication#destroy'


  resources :users
  resources :projects do
    resources :memberships
    resources :tasks do
      resources :comments, only: [:create]
    end
  end

  resources :pivotal_api, only: [:show]
end

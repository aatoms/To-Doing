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


  resources :tasks
  resources :users
  resources :projects

end

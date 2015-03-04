Rails.application.routes.draw do
  root 'welcome#index'
  get '/terms' => 'terms#index'
  get '/about' => 'about#index'
  get '/faq' => 'common_questions#index'
  get '/tasks' => 'tasks#index'
  get '/about' => 'about#index'
  get '/users' => 'users#index'
  get '/projects' => 'projects#index'
  resources :tasks
  resources :users
  resources :projects
end

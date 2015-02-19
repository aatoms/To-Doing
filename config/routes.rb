Rails.application.routes.draw do
   root to: 'welcome#index'
   get '/terms' => 'terms#index'
   get '/about' => 'about#index'
   get '/faq' => 'common_questions#index'
   get '/tasks' => 'tasks#index'

   resources :tasks

end

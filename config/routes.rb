Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions, only: [:create]
  resources :writers
  resources :managers
  resources :teams
  resources :tasks do
    resources :task_submissions, path: 'submissions'
  end

  post 'stats', to: 'stats#index'
  post '/checkPlag', :to => redirect('/plag-test.json')
end

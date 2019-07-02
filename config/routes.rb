Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions, only: [:create]
  resources :writers
  resources :managers
  resources :teams
  resources :publishing_platforms, path: 'platforms'
  resources :tasks do
    resources :task_submissions, path: 'submissions'
    resources :task_comments, path: 'comments'
  end

  post 'stats', to: 'stats#index'
end

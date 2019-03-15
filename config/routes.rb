Rails.application.routes.draw do
  root   'guests#index'
  get    'welcome', to: 'guests#welcome'

  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: %i[create edit update]
  end

  get    '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get    '/sign_up' => 'clearance/users#new', as: 'sign_up'

  get    'timer', to: 'timers#new'
  resources :timers, only: %i[new create]
  resources :logs,   only: %i[index new create destroy]
  resources :tags,   only: %i[index new create destroy]
end

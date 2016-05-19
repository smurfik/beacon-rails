Rails.application.routes.draw do
  root to: 'users#home'

  get 'sign-up', to: 'users#sign_up', as: :sign_up
  post 'sign-up', to: 'users#create'
  post 'sign-in', to: 'users#sign_in', as: :sign_in
  get 'sign-out', to: 'users#sign_out', as: :sign_out
  get 'register', to: 'users#register', as: :register

  post 'organizations', to: 'organizations#create'

  get 'organization-invites/new', to: 'organization_invites#new', as: :new_org
  post 'organization-invites', to: 'organization_invites#create', as: :create_org

end

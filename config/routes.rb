Rails.application.routes.draw do
  root 'dashboard#home'
  resources :emails, only: [:show, :new, :create]
  get '/emails/new_reply/:id', to: 'emails#new_reply', as: 'new_email_reply'
end

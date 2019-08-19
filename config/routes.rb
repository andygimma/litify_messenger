Rails.application.routes.draw do
  root 'dashboard#home'
  get '/chat', to: 'dashboard#chat', as: 'dashboard_chat'
  resources :emails, only: [:show, :new, :create]
  resources :message_threads, only: [:show]
  get '/emails/new_reply/:id', to: 'emails#new_reply', as: 'new_email_reply'
end

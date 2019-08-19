Rails.application.routes.draw do
  root 'dashboard#home'
  get '/chat', to: 'dashboard#chat', as: 'dashboard_chat'
  resources :emails, only: [:show, :new, :create]
  resources :chats, only: [:new, :create]

  get '/emails/new_reply/:id', to: 'emails#new_reply', as: 'new_email_reply'
  get '/chats/new_reply/:id', to: 'chats#new_reply', as: 'new_chat_reply'

  get '/email_threads/:id', to: 'message_threads#show_email_thread', as: 'show_email_thread'
  get '/chat_threads/:id', to: 'message_threads#show_chat_thread', as: 'show_chat_thread'

end

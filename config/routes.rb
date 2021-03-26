Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resource :targets
    put '/targets/:id', to: 'targets#update'
    delete '/targets/:id', to: 'targets#destroy'

    get 'months', to: 'months#show'
    post 'months', to: 'months#create'
    delete 'months/:id', to: 'months#destroy'

    get 'target_lists/:id', to: 'target_lists#show'
    post 'target_lists/:id', to: 'target_lists#upsert'
    put 'target_lists/:id', to: 'target_lists#upsert'
    delete 'target_lists/:id', to: 'target_lists#destroy'
  end
  
end

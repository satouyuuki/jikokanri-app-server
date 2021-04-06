Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post 'auth/sign_in', to: 'auth#sign_in'
    post 'auth/sign_out', to: 'auth#sign_out'
    post 'auth/invitation', to: 'auth#invitation'

    get 'months', to: 'months#show'
    post 'months', to: 'months#create'
    delete 'months/:id', to: 'months#destroy'

    get 'target_lists/:month_id', to: 'target_lists#show'
    post 'target_lists', to: 'target_lists#upsert'
    put 'target_lists', to: 'target_lists#upsert'
    delete 'target_lists/:id', to: 'target_lists#destroy'

    get 'done_lists/:week_id', to: 'week_done_lists#show'
    post 'done_lists', to: 'week_done_lists#upsert'
    delete 'done_lists/:id', to: 'week_done_lists#destroy'
  end
  
end

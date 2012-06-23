Ops::Application.routes.draw do
  resources :items do
    post 'sort', on: :collection
  end
  resources :operations
  resources :pilots
  resources :sites
end

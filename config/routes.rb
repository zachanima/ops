Ops::Application.routes.draw do
  resources :items do
    post 'sort', on: :collection
  end
  resources :operations do
    post 'pay', on: :collection
  end
  resources :pilots
  resources :sites
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :engagements, only: [:index, :create, :update, :destroy, :show ]
      resources :issues, only: [:index, :create, :update, :destroy, :show ]
      resources :agencies, only: [:index, :create, :update, :destroy, :show ]
      resources :staff, only: [:index, :create, :update, :destroy, :show ]
    end
  end
end

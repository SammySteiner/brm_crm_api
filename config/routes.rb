Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :engagements, only: [:index, :create, :update, :destroy, :show ]
      resources :connections, only: [:index, :create, :update, :destroy, :show ]
      resources :agencies, only: [:index, :create, :update, :destroy, :show ]
      resources :staff, only: [:index, :create, :update, :destroy, :show ]
      resources :services, only: [:index, :create, :update, :destroy, :show ]
      resources :user, only: [:index, :create, :update, :destroy, :show ]

      get 'agenciesFormInfo', to: 'agencies#formInfo'
      get 'staffFormInfo', to: 'staff#formInfo'
      get 'servicesFormInfo', to: 'services#formInfo'

      post 'auth', to: 'auth#create'

    end
  end
end

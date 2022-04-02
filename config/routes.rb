Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # v1 apis defined here
      resources :campaigns, only: [:index] do
        member do
          post 'make_investment', to: 'campaigns#make_investment'
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

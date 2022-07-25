Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  default_url_options :host => "example.com"
  namespace :api do
    namespace :v1 do
      resources :boutiques do
        collection do
          get :order
          post :catalog
        end
      end
    end
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "extendi#index"

  resources :extendi, :path => "/" do
    collection do
      post 'generate' => 'extendi#generate' 
      post 'clear' => 'extendi#clear' 
    end
  end
end

Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :questions do
    #this will define a oute that will be 'questions/search' and ti will point to the question controller 'search' action in that controller.
    #on: :collection makes the route not have an 'id' or 'question_id' on it
    get :search, on: :collection

    #this will generate a route '/questions/:id/flag' and it will point to questiosn contorller 'flag' action.
    #on: :member amkes the route include an ':id' in it similar to the 'edit'
    post :flag, on: :member

    post :mark_done

    # this will make all the answers routes nested within 'questions' which means al the answers routes will be prepended with '/questions/:question_id'
    resources :answers, only: [:create, :destroy]
  end

  # get "/questions/new" => "questions#new",    as: :new_question
  # post "/questions"    => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show",   as: :question
  # get "/questions"     => "questions#index"
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"

  #this defines a route that specifies if we get a request that has a GET HTTP verb with '/about' url, use teh HomeController with about action (method)
  get ({"/about" => "home#about"})
  # get "/"      => "home#index"
  root "home#index"

  #Note that helpers are only for the URL portion of the route and has nothign to do with the HTTP Verb. Also, note that a URL helper must be unique

  get "/cowsay" => "cowsay#index"

  post "/cowsay" => "cowsay#create", as: :cowsay_submit

  get "/temp_converter"  => "temp_converter#index"
  post "/temp_converter" => "temp_converter#index"

  get "/bill_splitter"  => "bill_splitter#index"
  post "/bill_splitter" => "bill_splitter#create"

  get "/winner"  => "winner#index"
  post "/winner" => "winner#create"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/auth/login', to: 'authentication#login'


  get "/user/(:id)", to: "user#getAllUser"
  post "/user", to: "user#getUserByEmailPassword"
  post "/createuser", to: "user#createUser"
  put "/user/:id", to: "user#updateUser"
  delete "/user/:id", to: "user#deleteUser"


  # Post routing 
  get "/post/(:id)", to: "post#getAllPost"
  get "/userpost/:id", to: "post#getPostByUser"
  post "/createpost", to: "post#createPost"
  put "/post/:id", to: "post#updatePost"
  delete "/post/:id", to: "post#deletePost"


  #Like routing
  get "/userlike/:id", to: "like#getUserLikedPost"
  post "/like", to: "like#likeDislike"


  #Tag routing 
  get "/tag/:id", to: "tag#getPostByTag"
  get "/tags", to: "tag#getAllTags"


  # Is jwtvalid
  get "/check", to: "user#checkValid"
end

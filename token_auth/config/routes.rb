Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get "/users/validate", to: "users#validate"
post "/users", to: "users#create"
post "/login", to: "sessions#create"

get "/movies/:zip/:date" => "movies#movies", :as => :show_movies
get "/tv" => "movies#tv", :as => :show_tv
get "/food/:zip/:meal" => "movies#food", :as => :get_food

get "/next/:title" => "movies#next_episode", :as => :show_next_episode

get "/weather/:zip" => "movies#weather", :as => :show_weather

post "/save", to: "movies#save"

end

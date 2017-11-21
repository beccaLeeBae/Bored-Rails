class MoviesController < ApplicationController

# before_action :set_user, only: [:save]

def movies
	zip = params[:zip]
	date = params[:date]
	url = "http://data.tmsapi.com/v1.1/movies/showings?startDate=#{date}&zip=#{zip}&radius=5&api_key=#{ENV['TMSKEY']}"
	movie_results = HTTParty.get(url)
	parsed_results = JSON.parse(movie_results.body)
	render json: parsed_results
end

def food
	zip = params[:zip]
	meal = params[:meal]
	url = "http://api.foursquare.com/v2/venues/explore?near=#{zip}&query=#{meal}&client_id=#{ENV['FSQKEY']}&client_secret=#{ENV['FSQSECRET']}&v=20171119&limit=10"
	food_results = HTTParty.get(url)
	parsed_results = JSON.parse(food_results.body)
	render json: parsed_results
end

def tv
	url = "https://api.themoviedb.org/3/tv/airing_today?api_key=#{ENV['MDBKEY']}&language=en-US&page=1"
	tv_results = HTTParty.get(url)
	parsed_results = JSON.parse(tv_results.body)
	render json: parsed_results
end

def next_episode
	title = params[:title]
	url = "http://api.tvmaze.com/search/shows?q=#{title}"
	episode_results = HTTParty.get(url)
	parsed_results = JSON.parse(episode_results.body)
	render json: parsed_results
end

def weather
	zip = params[:zip]
	url = "http://api.openweathermap.org/data/2.5/weather?zip=#{zip},us&APPID=#{ENV['OWKEY']}&units=imperial"
	weather_results = HTTParty.get(url)
	parsed_results = JSON.parse(weather_results.body)
	render json: parsed_results
end

 def save
   @movie = Movie.new(movie_params)
   if @movie.valid?
     	@movie.save
      render json: {success: true}
   else
      render json: {success: false}
  end
end

def saved
	movie_medium = params[:medium]
	id = params[:id]
	movie = Movie.where(medium: movie_medium, user_id: id).pluck(:title).uniq
	total_times = Movie.where(user_id: id).pluck(:title).uniq
	movie_length = movie.length
	times_length = total_times.length
	tv_length = times_length - movie_length
	puts movie_length
	render json: {
		movie_length: movie_length,
		tv_length: tv_length,
		total_times: times_length
	}
end

private

def set_user
	@user = User.find(params[:user_id])
	puts @user.id
end

def movie_params
	params.permit(:medium, :title, :user_id)
end

end

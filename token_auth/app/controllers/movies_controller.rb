class MoviesController < ApplicationController

before_action :set_user

def movies
	zip = params[:zip]
	date = params[:date]
	url = "http://data.tmsapi.com/v1.1/movies/showings?startDate=#{date}&zip=#{zip}&radius=3&api_key=#{ENV['TMSKEY']}"
	movie_results = HTTParty.get(url)
	parsed_results = JSON.parse(movie_results.body)
	puts parsed_results
	render json: parsed_results
end

def tv
	url = "https://api.themoviedb.org/3/tv/airing_today?api_key=#{ENV['MDBKEY']}&language=en-US&page=1"
	tv_results = HTTParty.get(url)
	parsed_results = JSON.parse(tv_results.body)
	puts parsed_results
	render json: parsed_results
end

def save
	puts save_params
	puts @user.id
	@movie = @user.movies.create(save_params)
end

private

def set_user
	@user = User.find(params[:user_id])
	puts @user.id
end

def save_params
	params.require(:movie).permit(:medium, :title, :user_id)
end

end

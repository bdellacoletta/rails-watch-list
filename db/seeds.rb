# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['THE_MOVIE_DB_KEY']}&language=en-US&page="

poster_base_url = 'https://image.tmdb.org/t/p/w500'


puts 'Creating movies'.center(40,'=')
20.times do |i|
  movie_data = JSON.parse(URI.open("#{url}#{i + 1}").read)['results']
  movie_data.each do |movie|
    next unless Movie.find_by_title(movie['title']).nil?
    movie = Movie.create!(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{poster_base_url}#{movie['poster_path']}",
      rating: movie['vote_average']
    )
  puts "'#{movie.title}' created."
  end
end

puts "#{Movie.count} movies created."

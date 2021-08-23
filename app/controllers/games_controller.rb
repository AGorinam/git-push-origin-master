class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word]
    @word_array = @word.split("")
    @word_array.each do |letter|
      if @letters.include?(letter) == false
        @answer = "Sorry but #{@word.upcase} can't be build out of #{@word_array.join(", ").upcase}"
      elsif english_word(@word) == false
        @answer = "Sorry but #{@word.upcase} does not seem to be a valid English word"
      else
        @answer = "Congratulations! #{@word.upcase} is a valid English word!"
      end
    end
  end

  require "open-uri"

  def english_word(word)
    @url = "https://wagon-dictionary.herokuapp.com/#{word}";
    parsing = JSON.parse(open(@url).read)
    parsing["found"]
  end
end

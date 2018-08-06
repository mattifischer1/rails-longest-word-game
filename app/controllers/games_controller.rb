require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)]}
  end

  def score
    @answer = params[:word]
    @letters = params[:letters]
    @test_word = test_word?(@answer, @letters)
    @english_word = english_word?(@answer)
  end

  def test_word?(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end

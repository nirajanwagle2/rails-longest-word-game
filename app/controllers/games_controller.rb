require "json"
require "nokogiri"
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    @word = params[:text]
    @valid = fetching_word(params[:text])
    if @valid
      @meaning = meaning(params[:text])
    end

  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def fetching_word(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def meaning(word)
    response = URI.open("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
    json = JSON.parse(response.read)
    return json[0]["meanings"][0]["definitions"][0]["definition"]

  end
end

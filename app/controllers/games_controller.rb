require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.shuffle[0, 12]
  end

  def create
    render plain: "Add to DB games word #{params[:word]}"
  end


  def valid?
    @word = params[:word]
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @wordcheck = open(@url).read
    @check = JSON.parse(@wordcheck)
    return @check['found']
  end

  def score
    @word = params[:word].split('')
    @letters = params[:letters].downcase.split
    @word.each_with_index do |index, letter|
      if @letters.include?(letter)
       @word.delete_at(index)
      end
    end
       @message = "Correct!" if valid? && @newword.nil?
       @message = "Sorry, this is not an English word" if valid? == false
       @message = "Please use the given words only" if valid? && @newword.nil? == false
   end
end

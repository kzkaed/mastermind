require 'spec_helper'
require 'mastermind/code_breaker'

describe Mastermind::CodeBreaker do

  let(:code_breaker) {described_class.new}


it 'makes a guess divide and con' do
  expect(code_breaker.make_guess_divide).to eq(["Red","Red","Yellow","Yellow"])
end


it 'receives response ' do
  response = [" "," "," "," "]
  expect(code_breaker.receive_response(response)).to eq([" "," "," "," "])
end


it 'determine best guess if response is empty' do
  #"Red","Red","Yellow","Yellow"
  guess_nums = [0, 0, 1, 1]
  response = [" "," "," "," "]
  expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Blue","Blue","Green","Green"])
end

  it 'determine best guess if response is empty next guess' do
    #"Blue","Blue","Green","Green"]
    guess_nums = [2, 2, 3, 3]
    response = [" "," "," "," "]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Black","Black","White","White"])
  end

  it 'makes best guess if response is o b b b' do
    guess_nums = [4, 4, 5, 5]#if 3 indexes are black change 3 indexes to either 2 -or 3-
    response = [" ","Black","Black","Black"]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Black","Black","Black","White"])
  end

  it 'makes best guess if response is b b w w' do
    guess_nums = [4, 4, 4, 5]#if first are correct last are switched
    response = ["Black","Black","White","White"]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Black","Black","White","Black"])
  end

  it 'wins if response is bbbb does not need to return best_guess' do
    #"Black","Black","White","White"
    guess_nums = [2, 2, 3, 3]
    response = ["Black","Black","Black","Black"]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq("COMPUTER WON")
  end

  it 'maps number to colors' do
    guess_nums = [0,0,0,0]
    expect(code_breaker.map_to_colors(guess_nums)).to eq(["Red","Red","Red","Red"])
  end

  it 'makes a guess all one color' do
    response = []
    expect(code_breaker.make_guess(response)).to eq(["Red","Red","Red","Red"])
  end

  it 'makes a new guess with yellow color passed in to eliminate that color' do
    guess = ["Red","Red","Red","Red"]
    response = ["","","",""]
    color = "Yellow"
    expect(code_breaker.make_new_guess(guess, response, color)).to eq(["Yellow","Yellow","Yellow","Yellow"])
  end

  it 'makes a new guess with any color passed in to eliminate that color' do
    guess = ["Red","Yellow","Blue","Green"]
    response = ["","","",""]
    color = "White"
    expect(code_breaker.make_new_guess(guess, response, color)).to eq(["White","White","White","White"])
  end


end


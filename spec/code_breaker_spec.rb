require 'spec_helper'
require 'mastermind/code_breaker'

describe Mastermind::CodeBreaker do

  let(:code_breaker) {described_class.new}


  it 'makes a guess divide and con' do
    expect(code_breaker.make_guess_divide).to eq(["Red", "Red", "Yellow", "Yellow"])
  end

  it 'determine best guess if response is empty' do
    guess_nums = [0, 0, 1, 1]
    response = [" ", " ", " ", " "]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Blue", "Blue", "Green", "Green"])
  end

  it 'determine best guess if response is empty next guess' do
    guess_nums = [2, 2, 3, 3]
    response = [" ", " ", " ", " "]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Black", "Black", "White", "White"])
  end

  it 'makes best guess if response is o b b b if change swap ' do
    guess_nums = [4, 4, 5, 5]
    response = [" ", "Black", "Black", "Black"]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Black", "Black", "Black", "White"])
  end

  it 'makes best guess if response is b b w w - if first are correct last are switched' do
    guess_nums = [4, 4, 4, 5]
    response = ["Black", "Black", "White", "White"]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq(["Black", "Black", "White", "Black"])
  end

  it 'wins if response is bbbb does not need to return best_guess' do
    guess_nums = [2, 2, 3, 3]
    response = ["Black", "Black", "Black", "Black"]
    expect(code_breaker.determine_best_guess(guess_nums, response)).to eq("COMPUTER WON")
  end

  it 'maps number to colors' do
    guess_nums = [0, 0, 0, 0]
    expect(code_breaker.map_to_colors(guess_nums)).to eq(["Red", "Red", "Red", "Red"])
  end

  it 'makes a new guess with yellow color passed in to eliminate that color if black' do
    guess = ["Red", "Red", "Red", "Red"]
    response = ["", "", "", ""]
    color = "Yellow"
    expect(code_breaker.make_new_guess(guess, response, color)).to eq(["Yellow", "Yellow", "Yellow", "Yellow"])
  end

  it 'makes a new guess with any color passed in to eliminate that color if response black' do
    guess = ["Red", "Yellow", "Blue", "Green"]
    response = ["", "", "", ""]
    color = "White"
    expect(code_breaker.make_new_guess(guess, response, color)).to eq(["White", "White", "White", "White"])
  end

  it 'returns color from  color set' do
    guess = ["Red","Red","Red","Yellow"]
    old_color_set = {'Red' => 3, 'Yellow' => 1, 'Blue' => 0, 'Green' => 0, 'Black' => 0, 'White' => 0}
    expect(code_breaker.get_color_set(old_color_set)).to eq(["Red","Yellow"])
  end


  it 'tries each color in each position returns each guess'do
    secret_code = ["Red","Red","Red","Yellow"]
    guess = ["Red", "Red", "Red", "Red"]
    response = ["", "Black", "Black", "Black"]#
    color = "Yellow" #try yellow in each of the positions before next color
    #expect(code_breaker.refine_guess(guess, response, color)).to eq(["Yellow", "Red", "Red", "Red"])

    #expect(code_breaker.refine_guess(guess, response, color)).to eq(["Red","Yellow", "Red", "Red"])
    #expect(code_breaker.refine_guess(guess, response, color)).to eq(["Red", "Red", "Yellow", "Red"])
    #expect(code_breaker.refine_guess(guess, response, color)).to eq(["Red", "Red", "Red", "Yellow"])
  end


  it 'has a hash color counts initialzed to 0' do
    expect(code_breaker.color_count).to include('Red' => 0,
                                                'Yellow' => 0,
                                                'Blue' => 0,
                                                'Green' => 0,
                                                'Black' => 0,
                                                'White' => 0)
  end

  it 'counts the number of black or white pegs in response for all red guess' do
    secret_code = ["Red","Red","Red","Yellow"]
    guess = ["Red","Red","Red","Red"]
    color = "Red"
    response = ["", "Black", "Black", "Black"]
    expect(code_breaker.count_colors(response, color)).to include('Red' => 3,
                                                                  'Yellow' => 0,
                                                                  'Blue' => 0,
                                                                  'Green' => 0,
                                                                  'Black' => 0,
                                                                  'White' => 0)
  end

  it 'counts the number of black or white pegs in response for all yellow guess' do
    secret_code = ["Red","Red","Red","Yellow"]
    guess = ["Yellow","Yellow","Yellow","Yellow"]
    color = "Yellow"
    response = ["", "", "", "Black"]
    expect(code_breaker.count_colors(response, color)).to include('Red' => 0,
                                                                  'Yellow' => 1,
                                                                  'Blue' => 0,
                                                                  'Green' => 0,
                                                                  'Black' => 0,
                                                                  'White' => 0)
  end



=begin
  it 'eliminates colors and return counts for those colors' do
    secret_code = ["Red","Red","Red","Yellow"]
    guess = ["Red","Red","Red","Red"]
    response = ["", "Black", "Black", "Black"]
    color = "Yellow"
    expect(code_breaker.count_colors(guess, response, color)).to eq([3,1,0,0,0,0])#could map it

  end
=end

  it 'make solid color guess' do
    color = "Red"
    response = ["","","",""]
    expect(code_breaker.make_solid_color_guess(response, color)).to eq(["Red","Red","Red","Red"])
  end

end


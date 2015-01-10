require 'spec_helper'
require 'mastermind/code_breaker'

describe Mastermind::CodeBreaker do

  let(:code_breaker) { described_class.new }

  it 'returns color from  color set' do
    guess = ["Red", "Red", "Red", "Yellow"]
    old_color_set = {'Red' => 3, 'Yellow' => 1, 'Blue' => 0, 'Green' => 0, 'Black' => 0, 'White' => 0}
    expect(code_breaker.get_color_set(old_color_set)).to eq(["Red", "Yellow"])
  end

=begin
  xit 'tries guess with color in all 4 positions returns each guess'do
    secret_code = ["Red","Red","Red","Yellow"]
    placeholder = "Blue"
    guess = ["Red", placeholder, placeholder, placeholder]
    response = ["", "", "", "Black"]#
    color = "Yellow" #try yellow in each of the positions before next color
    expect(code_breaker.refine_guess(guess, response, color)).to eq(["Red","Yellow", "Red", "Red"])

  end
=end

  it 'has a hash color counts initialzed to 0' do
    expect(code_breaker.color_count).to include('Red' => 0,
                                                'Yellow' => 0,
                                                'Blue' => 0,
                                                'Green' => 0,
                                                'Black' => 0,
                                                'White' => 0)
  end

  it 'counts the number of black or white pegs in response for all red guess' do
    secret_code = ["Red", "Red", "Red", "Yellow"]
    guess = ["Red", "Red", "Red", "Red"]
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
    secret_code = ["Red", "Red", "Red", "Yellow"]
    guess = ["Yellow", "Yellow", "Yellow", "Yellow"]
    color = "Yellow"
    response = ["", "", "", "Black"]
    expect(code_breaker.count_colors(response, color)).to include('Red' => 0,
                                                                  'Yellow' => 1,
                                                                  'Blue' => 0,
                                                                  'Green' => 0,
                                                                  'Black' => 0,
                                                                  'White' => 0)
  end


  it 'make solid color guess' do
    color = "Red"
    expect(code_breaker.make_solid_color_guess(color)).to eq(["Red", "Red", "Red", "Red"])
  end

  it 'determines placeholder' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.placeholder).to eq("White")
  end

  it 'makes a guess using placeholder and 1st color of color_set 2nd position' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.make_combination_guess([])).to eq(["Red", "White", "White", "White"])
  end

  it 'makes a guess using placeholder and 1st color of color_set 2nd position' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1


    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["Red", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "Red", "White", "White"])
  end

  it 'makes a guess using placeholder and 1st color of color_set 2nd position' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["Red", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "Red", "White", "White"])
    code_breaker.make_combination_guess(["Black", "", "", ""])
    expect(code_breaker.answer).to eq([nil, "Red", nil, nil])
    expect(code_breaker.color_count["Red"]).to eq(0)
  end

  it 'makes a guess using placeholder and 1st color of color_set 2nd position' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["Red", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "Red", "White", "White"])
    expect(code_breaker.make_combination_guess(["Black", "", "", ""])).to eq(["Yellow", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["Black", "", "", ""])).to eq(["Blue", "White", "White", "White"])
    expect(code_breaker.answer).to eq(["Yellow", "Red", nil, nil])
    expect(code_breaker.color_count["Yellow"]).to eq(0)
  end

  it 'makes a guess using placeholder and 1st color of color_set 2nd position' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["Red", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "Red", "White", "White"])
    expect(code_breaker.make_combination_guess(["Black", "", "", ""])).to eq(["Yellow", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["Black", "", "", ""])).to eq(["Blue", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "Blue", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "White", "Blue", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "White", "White", "Blue"])
    expect(code_breaker.make_combination_guess(["Black", "", "", ""])).to eq(["Green", "White", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "Green", "White", "White"])
    expect(code_breaker.make_combination_guess(["", "", "", ""])).to eq(["White", "White", "Green", "White"])
    expect(code_breaker.make_combination_guess(["Black", "", "", ""])).to eq(["Yellow", "Red", "Green", "Blue"])
    expect(code_breaker.answer).to eq(["Yellow", "Red", "Green", "Blue"])
    expect(code_breaker.color_count["Green"]).to eq(0)
  end

  it 'makes a guess where response is more than one black' do
    code_breaker.color_count["Red"] = 4
  end


  it 'determines color for next guess' do
    expect(code_breaker.guess_color_index).to eq(0)
    code_breaker.guess_color_index = 0
    expect(code_breaker.color_for_guess).to eq("Red")
    expect(code_breaker.guess_color_index).to eq(1)
  end

  it 'determines color for color count' do
    expect(code_breaker.count_color_index).to eq(0)
    code_breaker.count_color_index = 1
    expect(code_breaker.color_to_count).to eq("Yellow")
    expect(code_breaker.count_color_index).to eq(2)
  end

  it 'gets a total color count for each color' do
    code_breaker.color_count["Red"] = 3
    first_unplaced_color = "Red"
    expect(code_breaker.get_color_count(first_unplaced_color)).to eq(3)
  end


  it 'makes a list of all possible guesses ' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1
    code_breaker.possible_colors

    expect(code_breaker.fine_just_use_list).to eq([["Red", "Yellow", "Blue", "Green"],
                                                   ["Red", "Yellow", "Green", "Blue"],
                                                   ["Red", "Blue", "Yellow", "Green"],
                                                   ["Red", "Blue", "Green", "Yellow"],
                                                   ["Red", "Green", "Yellow", "Blue"],
                                                   ["Red", "Green", "Blue", "Yellow"],
                                                   ["Yellow", "Red", "Blue", "Green"],
                                                   ["Yellow", "Red", "Green", "Blue"],
                                                   ["Yellow", "Blue", "Red", "Green"],
                                                   ["Yellow", "Blue", "Green", "Red"],
                                                   ["Yellow", "Green", "Red", "Blue"],
                                                   ["Yellow", "Green", "Blue", "Red"],
                                                   ["Blue", "Red", "Yellow", "Green"],
                                                   ["Blue", "Red", "Green", "Yellow"],
                                                   ["Blue", "Yellow", "Red", "Green"],
                                                   ["Blue", "Yellow", "Green", "Red"],
                                                   ["Blue", "Green", "Red", "Yellow"],
                                                   ["Blue", "Green", "Yellow", "Red"],
                                                   ["Green", "Red", "Yellow", "Blue"],
                                                   ["Green", "Red", "Blue", "Yellow"],
                                                   ["Green", "Yellow", "Red", "Blue"],
                                                   ["Green", "Yellow", "Blue", "Red"],
                                                   ["Green", "Blue", "Red", "Yellow"],
                                                   ["Green", "Blue", "Yellow", "Red"]])
  end


  it 'makes a list of all possible colors from color counts' do
    code_breaker.color_count["Red"] = 1
    code_breaker.color_count["Yellow"] = 1
    code_breaker.color_count["Blue"] = 1
    code_breaker.color_count["Green"] = 1

    expect(code_breaker.possible_colors).to eq(["Red", "Yellow", "Blue", "Green"])
  end

  it 'makes a list of all possible colors from color counts' do
    code_breaker.color_count["Red"] = 4

    expect(code_breaker.possible_colors).to eq(["Red", "Red", "Red", "Red"])
  end

  it 'pops a guess from the permutations list' do
    code_breaker.color_count["Red"] = 4
    code_breaker.possible_colors
    expect(code_breaker.fine_just_use_list).to eq([["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"], ["Red", "Red", "Red", "Red"]])
    response = []
    expect(code_breaker.make_guess_from_permutations(response)).to eq(["Red", "Red", "Red", "Red"])
  end


end


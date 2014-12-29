require 'spec_helper'
require 'mastermind/code_maker'


describe Mastermind::CodeMaker do

  let(:code_maker) { described_class.new }


  it 'place secret code pegs' do
    code_maker.place_code(["Red", "Red", "Red", "Red"])
    expect(code_maker.secret_code).to match_array(["Red", "Red", "Red", "Red"])

  end


  it 'makes sure the secret code parameter is 4' do
    expect {code_maker.place_code(["Red", "Red", "Red", "Red", "Red"])}.to raise_error(Mastermind::InvalidCode, "Too many pegs")
    expect {code_maker.place_code(["Red","Red","Red"])}.to raise_error(Mastermind::InvalidCode,"Not enough pegs")
  end


  it 'random number should be between 0 and 5' do
    code_maker.generate_random_code
    expect(code_maker.random_nums[0]).to be_between(0, 5)
    expect(code_maker.random_nums[1]).to be_between(0, 5)
    expect(code_maker.random_nums[2]).to be_between(0, 5)
    expect(code_maker.random_nums[3]).to be_between(0, 5)
  end


  it 'secret code should be colors from COLORS' do
    code_maker.random_nums = [1, 2, 3, 4]
    code_maker.place_generated_code
    expect(code_maker.secret_code).to include "Yellow", "Black", "White", "Blue"
  end



  it 'all guesses are processed in capitalize format' do
    code_maker.validate_and_place_guess(["red","RED","reD", "Red"])
    expect(code_maker.guess).to match_array(["Red","Red","Red","Red"])
  end


  it 'returns message if guess is not a correct color in validate_guess' do
    code_maker.validate_and_place_guess(["Cyan","Red","Red" "Red"])
    expect(code_maker.message).to eq("Incorrect Color")
  end

  it 'sets guess to empty if guess is not correct color in validate_guess' do
    code_maker.validate_and_place_guess(["Cyan","Red","Red" "Red"])
    expect(code_maker.guess).to eq([])

  end

  it 'place code secret code should match @secret_code' do
    expect(code_maker.place_code(["Red","Blue","Yellow","Yellow"])).to eq(code_maker.secret_code)
  end


  it 'guess is all one color and code is random' do
    code_maker.secret_code = ["Red","Blue","Yellow","Yellow"]
    expect(code_maker.determine_and_place_response(["Red", "Red", "Red", "Red"])).to match_array(["Black","","",""])
  end

  it 'guesses 1 black match' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.determine_and_place_response(["Red","Green","Yellow","Blue"])).to match_array(["Black", "","",""])
  end

  it 'guesses 2 black match' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.determine_and_place_response(["Red","Red","Yellow","Blue"])).to match_array(["Black","Black","",""])
  end

  it 'guesses 1 match with yellow and index offset' do
    code_maker.secret_code = ["Yellow", "Blue", "Yellow", "Yellow"]
    expect(code_maker.determine_and_place_response(["Yellow","Yellow","Blue","Blue"])).to match_array(["Black","White","White",""])

  end

  it 'guesses 4 match with red' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.determine_and_place_response(["Red","Red","Red","Red"])).to match_array(["Black","Black","Black","Black"])
  end

  it 'guesses right color and wrong spot returns white' do
    code_maker.secret_code = ["Red", "Blue", "Green", "Yellow"]
    expect(code_maker.determine_and_place_response(["White","Red","White","White"])).to match_array(["","White", "", ""])
  end

  it 'verifies that secret code is original code after receive_guess' do
    code_maker.secret_code = ["Red", "Red", "Red", "Red"]
    expect(code_maker.determine_and_place_response(["Red","Red","Red","Red"])).to match_array(["Black","Black","Black","Black"])
    expect(code_maker.secret_code).to match_array(["Red", "Red", "Red", "Red"])

  end

  it 'if duplicate colors in guess, cannot be awarded a key peg' do
    code_maker.secret_code = ["White", "White", "Black", "Black"]
    expect(code_maker.determine_and_place_response(["White","White","White","Black"])).to match_array(["Black","Black", "", "Black"])

  end


  it 'if duplicate colors in guess, cannot be awarded key peg in different order' do
    code_maker.secret_code = ["Yellow","Black","Black","Yellow"]
    expect(code_maker.determine_and_place_response(["Yellow","Black","Yellow","Yellow"])).to match_array(["Black","Black", "", "Black"])
  end

end

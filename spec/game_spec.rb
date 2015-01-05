
require 'spec_helper'
require 'mastermind/game'
require 'mastermind/code_maker'

describe Mastermind::Game do

  let(:game) { described_class.new }

  it 'finds end of game with all black array response' do  
    expect(game.end_of_game?( 1 , ["Black","Black","Black","Black"])).to eq(true)
  end

  it 'finds end of game with current_guess maximum 8' do
    expect(game.end_of_game?(9, ["","","",""])).to eq(true)
  end

  it 'won? return true if won game' do
    expect(game.won?(["Black", "Black", "Black", "Black"])).to eq(true)
  end

  it 'end_of_game lost will set won to false' do
    expect(game.won?(["","","",""])).to eq(false)
  end
  
  it "generates the secret code" do
    game.generate_code
    expect(game.code_maker.secret_code).not_to eq(nil)
  end
  
  it "takes turn" do  
    secret_code = game.generate_code.dup 

    expect(game.take_turn(secret_code)).to eq(["Black", "Black", "Black", "Black"])
  end
  
  it 'current_turn starts at 1' do
    expect(game.current_turn).to eq(1)
  end

  it 'increments current_turn by 1 when takes turn' do
     game.current_turn = 2
     guess = game.generate_code.dup 
     game.take_turn(guess)
     expect(game.current_turn).to eq(3)
  end
end
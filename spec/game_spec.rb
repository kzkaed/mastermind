
require 'spec_helper'
require 'mastermind/game'

describe Mastermind::Game do

  let(:game) { described_class.new }
  

  it 'finds end of game with all black array response' do  
    expect(game.end_of_game?( 1 , ["Black","Black","Black","Black"])).to eq(true)
  end

  it 'finds end of game with current_guess maximum 8' do
    expect(game.end_of_game?(9, ["","","",""])).to eq(true)
  end

  it 'set won to true if won game' do
    expect(game.won(true)).to eq(true)
  end
 

  it 'set won to false if lost game' do
    expect(game.won(false)).to eq(false)
  end

  it 'won? return true if won game' do
    game.won(true)
    expect(game.won?).to eq(true)

  end

  it 'won? return false if lost game' do
    game.won(true)
    expect(game.won?).to eq(true)

  end

  it 'has @won instance variable initialized to nil' do
    expect(game.won?).to eq(false)
  end

  it 'end_of_game won will set won to true' do
    game.end_of_game?( 1 , ["Black","Black","Black","Black"])
    expect(game.won?).to eq(true)
  end

  it 'end_of_game lost will set won to false' do
    game.end_of_game?(9, ["","","",""])
    expect(game.won?).to eq(false)
  end



end
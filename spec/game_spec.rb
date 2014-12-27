
require 'spec_helper'
require 'mastermind/game'

describe Mastermind::Game do

  let(:game) { described_class.new }
  

  it 'finds end of game with all black array response' do  
    expect(game.end_of_game?( 1 , ["Black","Black","Black","Black"])).to eq(true)
  end

  it 'finds end of game with current_guess maximum 8' do
    expect(game.end_of_game?(8, ["","","",""])).to eq(true)
  end

 
  
end
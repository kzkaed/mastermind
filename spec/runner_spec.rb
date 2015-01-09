require 'spec_helper'
require 'mastermind/runner'
require 'mocks/mock_user_interface'
require 'mocks/mock_game'
require 'mocks/mock_player'

describe Mastermind::Runner do
  
  let!(:game) { MockGame.new}
  let!(:user_interface) {MockUserInterface.new}
  let!(:player) {MockPlayer.new}
  let(:runner) {described_class.new(user_interface, game, player)}

  it "creates the game" do
    expect(runner.game).to eq(game)
  end
  
  it "generates the secret code" do
    runner.run
    expect(game.generate_code_called?).to eq(true)
  end

  
  it 'response start as empty array' do
    expect(runner.response).to eq([])
  end
  
  it "prints out game startup messages" do
    runner.run
    
    expect(user_interface.prepare_called?).to eq(true)
  end
  
  it 'user interface display turn if not end of game' do
    game.number_of_turns = 1
    
    runner.run
    
    expect(user_interface.display_current_turn_called?).to eq(true)    
  end
  
  it "user interface displays guess and response" do
    game.number_of_turns = 1
    guess = ["Red", "Red", "Red", "Red"]
    player.guesses << guess
    response = ["Black", "Black", "Black", "Black"]
    game.responses << response

    runner.run
    
    expect(user_interface.display_response_called?).to eq(true)
    expect(user_interface.response).to eq(response)
    expect(user_interface.guess).to eq(guess)
  end
  
  it "user interface displays game won" do
    game.number_of_turns = 1
    game.won = false
    runner.run
    
    expect(user_interface.display_game_result_called?).to eq(true)
    expect(user_interface.result).to eq(false)
  end

  it "sends guess to game" do
    game.number_of_turns = 1
    guess = ["Red", "Red", "Red", "Red"]
    player.guesses << guess
    
    runner.run

    expect(player.guess_called?).to eq(true)
    expect(game.take_turn_called?).to eq(true)
    expect(game.current_guess).to eq(guess)
  end

end
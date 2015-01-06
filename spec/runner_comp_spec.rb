require 'spec_helper'
require 'mastermind/runner_comp'
require 'mocks/mock_user_interface'
require 'mocks/mock_game'

describe Mastermind::RunnerComp do

  let!(:game) { MockGame.new}
  let!(:user_interface) {MockUserInterface.new}
  let(:runner_comp) {described_class.new(user_interface, game)}

  it "creates the game" do
    expect(runner_comp.game).to eq(game)
  end

  it "generates the secret code" do
    runner_comp.run
    expect(game.generate_code_called?).to eq(true)
  end

  it "current guess starts as 0" do
    expect(runner_comp.current_turn).to eql(0)
  end

  it 'response start as empty array' do
    expect(runner_comp.response).to eq([])
  end

  it "prints out game startup messages" do
    runner_comp.run

    expect(user_interface.prepare_called?).to eq(true)
  end

  it 'user interface display turn if not end of game' do
    game.number_of_turns = 1

    runner_comp.run

    expect(user_interface.display_current_turn_called?).to eq(true)
  end

  it "user interface displays guess and response" do
    game.number_of_turns = 1
    response = ["Black", "Black", "Black", "Black"]
    game.responses << response
    guess = ["Red", "Red", "Red", "Red"]
    game.guesses << guess
    runner_comp.run

    expect(user_interface.display_response_called?).to eq(true)
    expect(user_interface.response).to eq(response)
    expect(user_interface.guess).to eq(guess)
  end

  it "user interface displays game won" do
    game.number_of_turns = 1
    game.won = false
    runner_comp.run

    expect(user_interface.display_game_result_called?).to eq(true)
    expect(user_interface.result).to eq(false)
  end

  it "sends guess to game" do
    game.number_of_turns = 1
    guess = ["Red", "Red", "Red", "Red"]
    game.guesses << guess

    runner_comp.run

    expect(game.computer_guess_called?).to eq(true)
    expect(game.take_turn_called?).to eq(true)
    expect(game.current_guess).to eq(guess)
  end







end
require 'spec_helper'
require 'mastermind/runner'

class MockUserInterface
  
  def initialize
    @prepare_called = false
  end
  
  def prepare
    @prepare_called = true
  end
  
  def prepare_called?
    return @prepare_called
  end
  
end

class MockGame
  def initialize
    @end_of_game_called = false
  end
  
  def end_of_game?(current_turn, response)
    @end_of_game_called = true
   end
   
   def end_of_game_called?
     return @end_of_game_called
   end
end

describe Mastermind::Runner do
  
let(:runner_nil) {described_class.new(nil,nil)}
=begin
  it "creates the game" do
    #runner = described_class.new(nil)
    expect(runner_nil.game).not_to eq(nil)
  end
=end
  it "current guess starts as 0" do
    #runner = described_class.new(nil)
    expect(runner_nil.current_turn).to eql(0)
  end
  
  it 'response start as empty array' do
    #runner = described_class.new(nil)
    expect(runner_nil.response).to eq([])
  end
  
  it "prints out game startup messages" do
    user_interface = MockUserInterface.new
    game = MockGame.new
    runner = described_class.new(user_interface,game)
    
    runner.run
    
    expect(user_interface.prepare_called?).to eq(true)
  end
  
  it 'plays game if not end of game' do
    user_interface = MockUserInterface.new
    game = MockGame.new
    runner = described_class.new(user_interface, game)
    
    runner.run
    
    expect(game.end_of_game?(0, [])).to eq(true)
    
  end
  
  
end
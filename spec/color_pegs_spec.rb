require 'spec_helper'
require 'mastermind/color_pegs'


describe Mastermind::ColorPegs do

  let(:pegs) { described_class.new }



  it 'initializes color pegs' do
     expect(pegs.red).to eq("\033[31mRed\033[0m")

  end
end
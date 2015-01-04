require 'spec_helper'
require 'mastermind/color_pegs'


describe Mastermind::ColorPegs do

  let(:pegs) { described_class.new }



  it 'initializes color pegs' do
     expect(pegs.red).to eq("\033[31mRed\033[0m")
     expect(pegs.yellow).to eq("\033[33mYellow\033[0m")
     expect(pegs.blue).to eq("\033[34mBlue\033[0m")
     expect(pegs.green).to eq("\033[32mGreen\033[0m")
     expect(pegs.black).to eq("\033[30mBlack\033[0m")
     expect(pegs.white).to eq("\033[37mWhite\033[0m")



  end
end
require 'spec_helper'
require 'mastermind/pegs'


describe Mastermind::Pegs do

  let(:pegs) { described_class.new }



  it 'initializes color pegs' do
     expect(pegs.red).to eq("\033[31mRed\033[0m")
     expect(pegs.yellow).to eq("\033[33mYellow\033[0m")
     expect(pegs.blue).to eq("\033[34mBlue\033[0m")
     expect(pegs.green).to eq("\033[32mGreen\033[0m")
     expect(pegs.black).to eq("\033[30mBlack\033[0m")
     expect(pegs.white).to eq("\033[37mWhite\033[0m")



  end

  it 'makes a hash of color pegs for console output' do
    pegs.console_color_pegs
    expect(pegs.color_pegs).to include('Red' => pegs.red,
                                       'Yellow' => pegs.yellow,
                                       'Blue' => pegs.blue,
                                       'Green' => pegs.green,
                                       'Black' => pegs.black,
                                       'White' => pegs.white)
  end


  it 'makes a hash of key pegs for console output' do
    pegs.console_key_pegs
    expect(pegs.key_pegs).to include('Black' => pegs.black,
                                     'White' => pegs.white,
                                     '' => pegs.empty)
  end




end
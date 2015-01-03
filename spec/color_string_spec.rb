require 'spec_helper'
require 'mastermind/color_string'

describe Mastermind::ColorString do

let(:color_string) { described_class.new }

  it 'has a black method' do
    string = "Black"
    expect(color_string.black(string)).to eq("\033[30;47mBlack\033[0m")

  end

it 'has a black method' do
  string = "Red"
  expect(color_string.red(string)).to eq("\033[31mRed\033[0m")
end

  it 'has a magenta method' do
    string = "Magenta"
    expect(color_string.magenta(string)).to eq("\033[35mMagenta\033[0m")
  end


end



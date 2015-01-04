require 'spec_helper'
require 'mastermind/color_string'

describe Mastermind::ColorString do

let(:color_string) { described_class.new }

  it 'has a black method' do
    expect(color_string.black("Black")).to eq("\033[30mBlack\033[0m")
  end

  it 'has a white method' do
    expect(color_string.white("White")).to eq("\033[37mWhite\033[0m")
  end

  it 'has a red method' do
    expect(color_string.red("Red")).to eq("\033[31mRed\033[0m")
  end

  it 'has a yellow method' do
    expect(color_string.yellow("Yellow")).to eq("\033[33mYellow\033[0m")
  end

  it 'has a green method' do
    expect(color_string.green("Green")).to eq("\033[32mGreen\033[0m")
  end

  it 'has a blue method' do
    expect(color_string.blue("Blue")).to eq("\033[34mBlue\033[0m")
  end

  it 'has a magenta method' do
    expect(color_string.magenta("Magenta")).to eq("\033[35mMagenta\033[0m")
  end

it 'has a black on white method' do
  expect(color_string.black_on_white("Black")).to eq("\033[30;47mBlack\033[0m")
end

it 'has a white on black method' do
  expect(color_string.white_on_black("White")).to eq("\033[37;40mWhite\033[0m")
end

end



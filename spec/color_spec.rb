require 'spec_helper'
require 'mastermind/color'

describe Mastermind::Color do

let(:color) { described_class.new }

  it 'has a black method' do
    string = "black"
    expect(color.black(string)).to eq("\033[30m#{string}\033[0m")

  end

it 'has a black method' do
  string = "red"
  expect(color.red(string)).to eq("\033[31m#{string}\033[0m")
end

  it 'has a magenta method' do
    string = "magenta"
    expect(color.magenta(string)).to eq("\033[35m#{string}\033[0m")
  end


end



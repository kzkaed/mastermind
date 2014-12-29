
require 'spec_helper'
require 'mastermind/user_io'

describe Mastermind::MockIO do

  let(:mock_io) { described_class.new }
  it 'outputs a message' do
    mock_io.out('hello')

    expect(mock_io.outputs).to eq(['hello'])
  end

  it 'outputs two messages' do
    mock_io.out('hello')
    mock_io.out('world')

    expect(mock_io.outputs).to eq(['hello', 'world'])
  end

  it 'inputs a message' do
    mock_io.inputs = ['hello']
    expect(mock_io.in).to eq('hello')
  end

  it 'inputs 2 messages' do
    mock_io.inputs = ['hello','world']

    expect(mock_io.in).to eq('hello')
    expect(mock_io.in).to eq('world')
  end

end
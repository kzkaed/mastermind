#require 'rspec'
require 'spec_helper'
require 'mastermind/code_breaker'

#Mock?
require 'stringio'





describe Mastermind::CodeBreaker do

  let(:code_breaker) {described_class.new}
  #overwrite StringIO? for each do - a new StringIO per test gives you an isolated standard output mock to test against
  before do
    $stdout = StringIO.new #assign a new StringIO instance to var stdout
  end
  after(:all) do
    $stdout = STDOUT
  end

  it 'code_breaker is true' do
    expect(true).to eq(true)
    #STDOUT.should_receive(:puts).with("Welcome")
  end

  it 'code is false' do
    expect(code_breaker.code).to eq(false)
    end

  it 'puts to console welcome' do
   expect($stdout.string).to match("")
  end







end

=begin
# rather than:
foo.should == bar

# ...use:
expect(foo).to eq(bar)
=end

=begin
  it 'should read from console 4 colors in array' do
  STDIN.should_receive(:read).and_return("RED", "RED", "RED","RED")
    end
=end
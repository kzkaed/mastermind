require 'spec_helper'
require 'mastermind/code_maker_kristin'

describe Mastermind::CodeMakerKristin do

  #do specific cases then see what pattern is
  it 'make a code of 4 colors' do
      codemaker = described_class.new   #instantiate class
      codemaker.make_code(["Blue","Blue","Blue","Blue"]) #add array blues
      expect(codemaker.hidden_code).to match_array(["Blue","Blue","Blue","Blue"])#test expect array of blues

  end

  it 'code is 4 ' do  # 3 < code  < 5

    #collection size have_at_least, have_at_most(<n>).things, have(<n>).things
    #expect(codemaker.hidden_code).have(<4>).things
    #expect {codemaker.make_code(["Blue", "Blue", "Blue", "Blue", "Blue"])}.to raise_error(Mastermind::InvalidCode, "Too many pegs")

  end



end

module Mastermind

  class InvalidCode < Exception
  end

  class CodeMakerKristin
    attr_accessor :hidden_code #i thought this was optional?attr_accessor is a mehthod that takes :hiddencode as variable

    CODE_COLORS = ["Red", "Blue", "Green", "Yellow", "White","Black"]
    PEG_COLORS = ["White","Black"]

    def make_code(hidden_code)
      #make an array with 4 colors, not less, not more, and only the colors from CODE_COLOR



      @hidden_code = hidden_code
    end


  end
end
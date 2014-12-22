module Mastermind

  class MockIO
    attr_reader :outputs
    attr_writer :inputs

    def initialize
      @outputs = []
      @inputs = nil
    end

    def in
      @inputs.shift
    end


    def out (message)
      @outputs << message
    end
  end


  class UserIO
    def initialize

    end

    def in
      gets.chomp
    end

    def out(message)
      puts message
    end

  end
end
require_relative 'logic'

module Chess  
  class Player1 < Logic
    attr_reader :turn

    def initialize
      @array = Chess::Logic.array
      super
      initialize_board
    end

    def turn
      @turn = !@turn
    end

    def initialize_board 
      @array[6].map!.with_index do |piece, column_x| # map
        piece = piece column_x, 6, 10, 50, 80
      end
    end
  end

  class Player2 < Logic
    def initialize
      @array = Chess::Logic.array
      super
      initialize_board
    end

    def initialize_board 
      @array[1].map!.with_index do |piece, column_x| # map
        piece = piece column_x, 1, 10, 50, 80
      end
    end
  end
end


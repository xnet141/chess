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
        piece = piece 'images/bishop_white.png', column_x, 6, 80, 80, 0
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
        piece = piece 'images/knight_white.png', column_x, 1, 80, 80, 0
      end
    end
  end
end


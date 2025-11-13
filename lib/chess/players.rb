require_relative 'logic'

module Chess  
  class Player2 < Logic
    attr_accessor :count

    def initialize
      @array = Chess::Logic.array
      @count = 0
      super
      initialize_pawns 1, :black
      # initialize_officers 0, 'images/rook_black.png', 'images/knight_black.png', 'images/bishop_black.png', 'images/queen_black.png', 'images/king_black.png', 'images/bishop_black.png', 'images/knight_black.png', 'images/rook_black.png'
    end
  end

  class Player1 < Logic
    attr_accessor :count
    attr_reader :turn

    def initialize
      @array = Chess::Logic.array
      @count = 0
      super
      initialize_pawns 6, :white
      # initialize_officers 7, 'images/rook_white.png', 'images/knight_white.png', 'images/bishop_white.png', 'images/queen_white.png', 'images/king_white.png', 'images/bishop_white.png', 'images/knight_white.png', 'images/rook_white.png'
    end
  end
end


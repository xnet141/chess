require_relative 'logic'

module Chess  
  class Player1 < Logic
    attr_accessor :count
    attr_reader :turn

    def initialize
      @array = Chess::Logic.array
      # @self_array = Array.new(8) {Array.new(8)}
      @count = 0
      super
      initialize_pawns 6, 'images/pawn_white.png'
      initialize_officers 7, 'images/rook_white.png', 'images/knight_white.png', 'images/bishop_white.png', 'images/queen_white.png', 'images/king_white.png', 'images/bishop_white.png', 'images/knight_white.png', 'images/rook_white.png'
    end

    def turn
      @turn = !@turn
    end
  end

  class Player2 < Logic
    attr_accessor :count

    def initialize
      @array = Chess::Logic.array
      # @self_array = Array.new(8) {Array.new(8)}
      @count = 0
      super
      initialize_pawns 1, 'images/pawn_black.png'
      initialize_officers 0, 'images/rook_black.png', 'images/knight_black.png', 'images/bishop_black.png', 'images/queen_black.png', 'images/king_black.png', 'images/bishop_black.png', 'images/knight_black.png', 'images/rook_black.png'
    end
  end
end


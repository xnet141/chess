require_relative 'logic'

module Chess  
  class Player2 < Logic
    attr_reader :count
    attr_reader :players_turn

    def initialize
      @test = Chess::Logic.test
      @test2 = Chess::Logic.test2
      @array = Chess::Logic.array
      @count = 0
      @players_turn = Chess::Logic.players_turn
      super
      initialize_pawns 1, :black
      initialize_officers 0, :black, @chessmans #, 'images/rook_black.png', 'images/knight_black.png', 'images/bishop_black.png', 'images/queen_black.png', 'images/king_black.png', 'images/bishop_black.png', 'images/knight_black.png', 'images/rook_black.png'
    end
  end

  class Player1 < Logic
    attr_reader :count
    attr_reader :players_turn

    def initialize
      @test = Chess::Logic.test
      @test2 = Chess::Logic.test2
      @array = Chess::Logic.array
      @count = 0
      @players_turn = Chess::Logic.players_turn
      super
      initialize_pawns 6, :white
      initialize_officers 7, :white, @chessmans #, 'images/rook_white.png', 'images/knight_white.png', 'images/bishop_white.png', 'images/queen_white.png', 'images/king_white.png', 'images/bishop_white.png', 'images/knight_white.png', 'images/rook_white.png'
    end
  end
end


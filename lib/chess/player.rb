require_relative 'board'

module Chess
  class Player
    def initialize
      @array = Array.new(8) {Array.new(8)}
    end
    include Chess::Board # ::

    # class << self
    #   attr_accessor :array
    # end
    
    def logic event_x, event_y
      x = axis(event_x, event_y)[2]
      y = axis(event_x, event_y)[3]
      choose_square x, y
    end

    def choose_square x, y
      @array[x][y] = ImageWithArray.new(
        'images/pawn.png',
        x: x * GRID_SIZE + GRID_SIZE, y: y * GRID_SIZE + GRID_SIZE,
        width: 100, height: 100,
        color: [1.0, 1.0, 0.2, 0.9],
        rotate: 0,
        z: 10,
        data: [x, y]
      )
    end
  end  
end
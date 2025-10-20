require_relative 'board'

module Chess
  class Player
    def initialize
      @array = Array.new(8) {Array.new(8)}

      array = @array
      initialize_board array
    end
    include Chess::Board # ::
    
    # class << self
    #   attr_accessor :array
    # end

    def initialize_board array
      [1, 6].each.with_index do |raw_y|
        array[raw_y].map!.with_index do |item, column_x| # map
          # p column_item
          item = ImageWithArray.new(
            'images/pawn.png',
            x: column_x * GRID_SIZE + GRID_SIZE, y: raw_y * GRID_SIZE + GRID_SIZE,
            width: 100, height: 100,
            color: [1.0, 1.0, 0.2, 0.9],
            rotate: 0,
            z: 10,
            data: [column_x, raw_y]
          )
        end
      end

      p array
    end
    
    def logic event_x, event_y
      axis = axis(event_x, event_y)
      p axis
      return if axis.nil?
      x = axis[2]
      y = axis[3]
      
      choose_square x, y
    end

    private 

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
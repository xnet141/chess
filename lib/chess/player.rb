require_relative 'board'

module Chess
  class Player
    attr_reader :array

    def initialize
      @array = Array.new(8) {Array.new(8)}
      @mark_turn = true
      @mark_cordinates = nil
      @show_marked_piece = nil
      initialize_board 
    end
    include Chess::Board # ::
    
    # class << self
    #   attr_accessor :array
    # end

    def logic event_x, event_y
      axis = axis(event_x, event_y)
      p axis
      return if axis.nil?
      x = axis[2]
      y = axis[3]
      if @mark_turn
        p "!!!!!!!!!@mark_cordinates: #{@mark_cordinates.inspect}"
        mark_piece x, y
        p "!!!!!!!!!@mark_cordinates: #{@mark_cordinates.inspect}"
      else
        process_move x, y
        p "======@mark_cordinates: #{@mark_cordinates.inspect}"
      end
    end
    
    private 
    
    def initialize_board 
      [1, 6].each.with_index do |raw_y|
        @array[raw_y].map!.with_index do |item, column_x| # map
          item = piece column_x, raw_y, 10, 80, 80
        end
      end
    end

    def piece x, y, d, width, height, color = 1.0
      ImageWithArray.new(
        'images/pawn.png',
        # x: x * GRID_SIZE + GRID_SIZE + d, y: y * GRID_SIZE + GRID_SIZE + d,
        width: width, height: height,
        color: [1.0, 1.0, 1.0, color],
        rotate: 0,
        z: 0,
        d: d,
        data: [x, y]
      )
    end

    def mark_piece x, y
      if @array[y][x].class == ImageWithArray
        @show_marked_piece = piece x, y, 0, 100, 100, 0.6
        @mark_turn = !@mark_turn
        @mark_cordinates = [y, x]
      end
    end

    def unmark_piece
      @show_marked_piece.remove unless @show_marked_piece.nil?
      @show_marked_piece = nil
      @mark_cordinates = nil
      @mark_turn = !@mark_turn
    end

    def do_move x, y
      if @array[y][x].nil?
        @array[y][x] = @array[@mark_cordinates[0]][@mark_cordinates[1]]
        @array[@mark_cordinates[0]][@mark_cordinates[1]].remove
        @array[@mark_cordinates[0]][@mark_cordinates[1]] = nil
        @array[y][x].new_coordinates x, y, 10
        @array[y][x].add
      end
    end
    
    def process_move x, y
      # p "&&&&& @mark_cordinates: #{@mark_cordinates}"
      # p "begin @array[x][y]: #{@array[y][x].class}"
      if do_move x, y
        unmark_piece
      else
        unmark_piece
      end
      # p "end @array[x][y]: #{@array[x][y].inspect}"
    end 
  end  
end
require_relative 'board'

module Chess
  class Logic
    include Chess::Board

    attr_reader :array

    def initialize
      @mark_turn = true
      @mark_cordinates = nil
      @show_marked_piece = nil
      # initialize_board 
    end

    @array = Array.new(8) {Array.new(8)}
    @player_turn = true    

    class << self
      attr_accessor :array, :player_turn
    end

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
    
    # def initialize_board 
    #   [1, 6].each.with_index do |raw_y|
    #     @array[raw_y].map!.with_index do |piece, column_x| # map
    #       piece = piece column_x, raw_y, 10, 80, 80
    #     end
    #   end
    # end

    def piece path, x, y, width, height, color = 1.0, d
      ImageWithArray.new(
        path,
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
        path_image = @array[y][x].path
        p "path #{path_image}"
        @show_marked_piece = piece path_image, x, y, 100, 100, 0.8, -10
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
        @array[y][x].new_coordinates x, y, 0
        @array[y][x].add
        Chess::Logic.player_turn = !Chess::Logic.player_turn
      end
    end
    
    def process_move x, y # лишний метод пока
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
require_relative 'board'

module Chess
  class Logic
    include Chess::Board

    attr_reader :array

    def initialize
      @mark_turn = true
      @mark_cordinates = nil
      @show_marked_piece = nil
      @path_squares = []
      # initialize_board 
    end

    @array = Array.new(8) {Array.new(8)}
    @players_turn = true    

    class << self
      attr_accessor :array, :players_turn
    end

    def logic event_x, event_y
      axis = axis(event_x, event_y)
      p axis
      return if axis.nil?
      x = axis[2]
      y = axis[3]
      if @mark_turn
        # p "!!!!!!!!!@mark_cordinates: #{@mark_cordinates.inspect}"
        process_mark x, y
        # p "!!!!!!!!!@mark_cordinates: #{@mark_cordinates.inspect}"
      else
        process_move x, y
        # p "======@mark_cordinates: #{@mark_cordinates.inspect}"
      end
    end
    
    private 

    def piece path, data_x, data_y, width, height, transparency = 1.0, d
      if data_x >= 0 && data_x <= 7 && data_y >= 0 && data_y <= 7
        PieceImage.new(
          path,
          # x: x * GRID_SIZE + GRID_SIZE + d, y: y * GRID_SIZE + GRID_SIZE + d,
          width: width, height: height,
          color: [1.0, 1.0, 1.0, transparency],
          rotate: 0,
          z: 0,
          d: d,
          data: [data_x, data_y],
          get_class: self.class
        )
      end
    end
    
    def initialize_pawns row_pawns, path
      @array[row_pawns].map!.with_index do |item, column_pawn| # map
        piece path, column_pawn, row_pawns, 80, 80, 0
      end
    end

    def initialize_officers row_officers, *paths
      @array[row_officers] = paths.map.with_index do |path, column_officer|
        piece path, column_officer, row_officers, 80, 80, 0
      end 
    end

    def is_my_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class == self.class
    end

    def is_enemy_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class != self.class
    end

    def is_square_nil? x, y 
      @array[y][x].nil?
    end
    
    def mark_piece x, y
      if is_my_piece?(x, y)
        @show_marked_piece = piece @array[y][x].path, x, y, 100, 100, 0.8, -10
        @mark_cordinates = [y, x]
        @mark_turn = !@mark_turn
      end
    end
    
    def show_path x, y
      if is_my_piece?(x, y)
        if @array[y][x].get_class == Player1
          @path_squares = (y-2..y-1).map do |item_y| 
            p "item_y: #{item_y}"
            piece @array[y][x].path ,x ,item_y , 100, 100, 0.8, -10 
          end
          path_first = @path_squares.first
          if path_first
            path_cell = piece(@array[y][x].path ,x+1 ,path_first.data[1] , 100, 100, 0.8, -10)
            @path_squares << path_cell if !path_cell.nil?
            path_cell = piece(@array[y][x].path ,x-1 ,path_first.data[1] , 100, 100, 0.8, -10)
            @path_squares << path_cell if !path_cell.nil?
          end
        else 
          @path_squares = (y+1..y+2).map do |item_y| 
            p "item_y: #{item_y}"
            piece @array[y][x].path ,x ,item_y , 100, 100, 0.8, -10 
          end
          path_last = @path_squares.last
          if path_last
            path_cell = piece(@array[y][x].path ,x+1 ,path_last.data[1] , 100, 100, 0.8, -10)
            @path_squares << path_cell if !path_cell.nil?
            path_cell = piece(@array[y][x].path ,x-1 ,path_last.data[1] , 100, 100, 0.8, -10)
            @path_squares << path_cell if !path_cell.nil?
          end        
        end
      end
    end
    
    def remove_piece x, y
      if is_enemy_piece? x, y
        @array[y][x].remove
        @array[y][x] = nil
        @count += 1
      end
    end
    
    def unmark_piece
      @show_marked_piece.remove unless @show_marked_piece.nil? # unless... не обязательно
      @show_marked_piece = nil
      @mark_cordinates = nil
      @mark_turn = !@mark_turn
    end

    def cancel_show_path
      @path_squares.each(&:remove)
    end

    def make_move x, y
      if @array[y][x].nil?
        @array[y][x] = @array[@mark_cordinates[0]][@mark_cordinates[1]]
        @array[@mark_cordinates[0]][@mark_cordinates[1]].remove
        @array[@mark_cordinates[0]][@mark_cordinates[1]] = nil
        @array[y][x].new_coordinates x, y, 0
        @array[y][x].add
        Chess::Logic.players_turn = !Chess::Logic.players_turn
      end
    end

    def process_mark x, y
      show_path x, y 

      mark_piece x, y
    end

    def undo_mark
      cancel_show_path

      unmark_piece
    end

    def process_move x, y
      remove_piece x, y

      make_move x, y

      undo_mark
    end
  end
end
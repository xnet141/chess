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
        mark_piece x, y
        # p "!!!!!!!!!@mark_cordinates: #{@mark_cordinates.inspect}"
      else
        process_move x, y
        # p "======@mark_cordinates: #{@mark_cordinates.inspect}"
      end
    end
    
    private 

    def piece path, data_x, data_y, width, height, transparency = 1.0, d
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
    
    def mark_piece x, y
      if !@array[y][x].nil? && @array[y][x].get_class == self.class
        path_image = @array[y][x].path
        @show_marked_piece = piece path_image, x, y, 100, 100, 0.8, -10
        @mark_cordinates = [y, x]
        @mark_turn = !@mark_turn
      end
    end
    
    def unmark_piece
      @show_marked_piece.remove unless @show_marked_piece.nil? # unless... не обязательно
      @show_marked_piece = nil
      @mark_cordinates = nil
      @mark_turn = !@mark_turn
    end
    
    def remove_piece x, y
      if !@array[y][x].nil? && @array[y][x].get_class != self.class
        @array[y][x].remove
        @array[y][x] = nil
        @count += 1
      end
    end

    def show_move_path
      # нужно название фигуры - может класс?
      # название фигуры считываем из названия файла, учесть что фигуры дублируются
      # преобразуем это в методе piece
      # описать ходы фигуры в PieceImage
      # [y+3][x+1]
      # [y+3][x-1]
      # [y-3][x+1]
      # [y-3][x-1]
      # [y+1][x+3]
      # [y+1][x-3]
      # [y-1][x+3]
      # [y-1][x-3]

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

    def process_move x, y
      remove_piece x, y

      make_move x, y

      unmark_piece
    end
  end
end
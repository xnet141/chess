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

    def is_my_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class == self.class
    end

    def is_enemy_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class != self.class
    end

    def square_nil? x, y 
      @array[y][x].nil?
    end
    
    def mark_piece x, y
      if is_my_piece? x, y
        path = (y-2..y-1).map do |item_y| 
          p "item_y: #{item_y}"
          piece @array[y][x].path ,x ,item_y , 100, 100, 0.8, -10 if square_nil? x ,item_y
        end
        p path.first.data[1]
        piece @array[y][x].path ,x+1 ,path.first.data[1] , 100, 100, 0.8, -10
        piece @array[y][x].path ,x-1 ,path.first.data[1] , 100, 100, 0.8, -10
        @show_marked_piece = piece @array[y][x].path, x, y, 100, 100, 0.8, -10
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
      if is_enemy_piece? x, y
        @array[y][x].remove
        @array[y][x] = nil
        @count += 1
      end
    end

    # def show_path x, y
    #   # нужно название фигуры - может класс?
    #   # название фигуры считываем из названия файла, учесть что фигуры дублируются
    #   # преобразуем это в методе piece
    #   # описать ходы фигуры в PieceImage
      
    #   if !@array[y][x].nil? && @array[y][x].get_class == self.class
    #     return
    #   else 
    #     (x+1..3).map do |item_x| 
    #       p item_x
    #       piece @array[y][x].path, item_x, y, 100, 100, 0.8, -10
    #     end
    #   end

    #   # [y+3][x+1]
    #   # [y+3][x-1]
    #   # [y-3][x+1]
    #   # [y-3][x-1]
    #   # [y+1][x+3]
    #   # [y+1][x-3]
    #   # [y-1][x+3]
    #   # [y-1][x-3]
    # end

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

    # def process_mark x, y

    # end

    def process_move x, y
      # show_path x, y

      remove_piece x, y

      make_move x, y

      unmark_piece
    end
  end
end
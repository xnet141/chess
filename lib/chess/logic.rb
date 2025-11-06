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
        process_mark x, y
      else
        process_move x, y
      end
    end
    
    private 

    def piece path, data_x, data_y, width, height, transparency = 1.0, d
      if (0..7).cover?(data_x) && (0..7).cover?(data_y)
        PieceImage.new(
          path,
          # x: x * GRID_SIZE + GRID_SIZE + hash, y: y * GRID_SIZE + GRID_SIZE + hash,
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

    def piece_for_mark img, x, y
      piece img, x, y, 120, 120, 0.9, -20
    end

    def piece_for_path img, x, y
      piece img, x, y, 100, 100, 0.6, -10
    end
    
    def initialize_pawns row_pawns, path
      @array[row_pawns].map!.with_index  {|item, column_pawn| piece path, column_pawn, row_pawns, 80, 80, 0}
    end

    def initialize_officers row_officers, *paths
      @array[row_officers] = paths.map.with_index {|path, column_officer| piece path, column_officer, row_officers, 80, 80, 0}
    end

    def is_my_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class == self.class
    end

    def is_enemy_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class != self.class
    end

    def mark_piece x, y
      if is_my_piece?(x, y)
        @show_marked_piece = piece_for_mark @array[y][x].img, x, y
        @mark_cordinates = [y, x]
        @mark_turn = !@mark_turn
      end
    end
    
    def show_path x, y
      if is_my_piece?(x, y)
        # if @array[y][x].get_class == Player1
        #   knight_path x, y, "Player1"
        # else 
          knight_path x, y#, "Player1"#"Player2"
        # end
      end
    end
    
    def knight_path x, y#, player
      arr1 = []; arr2 = []
      (0..7).cover?(y-2) ? arr1.push(y-2,y-1) : arr1.push(nil,nil)
      (0..7).cover?(y+2) ? arr1.push(y+1,y+2) : arr1.push(nil,nil)
      (0..7).cover?(x-2) ? arr2.push(x-2,x-1) : arr2.push(nil,nil)
      (0..7).cover?(x+2) ? arr2.push(x+1,x+2) : arr2.push(nil,nil)
      p "arr1 : #{arr1}"
      p "arr2 : #{arr2}"
      # hash = {"Player1" => [y-2,y-1,y+1,y+2]}#, ,y-2 "Player2" => [y+1,y+2,y+2]}
      arr1.map.with_index do |dy, index|
        @path_squares << piece_for_path(@array[y][x].img, x+1, dy) if index == 0
        @path_squares << piece_for_path(@array[y][x].img, x-1, dy) if index == 0
        @path_squares << piece_for_path(@array[y][x].img, x, dy)
        @path_squares << piece_for_path(@array[y][x].img, x+1, dy) if index == 3
        @path_squares << piece_for_path(@array[y][x].img, x-1, dy) if index == 3
      end
      arr2.map.with_index do |dx, index|
        @path_squares << piece_for_path(@array[y][x].img, dx, y+1) if index == 0
        @path_squares << piece_for_path(@array[y][x].img, dx, y-1) if index == 0
        @path_squares << piece_for_path(@array[y][x].img, dx, y)
        @path_squares << piece_for_path(@array[y][x].img, dx, y+1) if index == 3
        @path_squares << piece_for_path(@array[y][x].img, dx, y-1) if index == 3
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
      p "@path_squares: #{@path_squares}"
      @path_squares = @path_squares.reject(&:nil?).each(&:remove)
      @path_squares = []
      # @path_squares.compact.each(&:remove) # убрать все  nil
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
      mark_piece x, y
      
      show_path x, y 
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
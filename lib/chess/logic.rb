require_relative 'board'
require_relative 'pieces'

module Chess
  class Logic
    include Chess::Board
    include Chess::Pieces

    attr_reader :array

    def initialize
      @mark_turn = true
      @mark_cordinates = nil
      @show_marked_piece = nil
      @path_squares = []
      @chessmans = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
      # initialize_board 
    end

    def logic event_x, event_y
      axis = axis(event_x, event_y)
      p "axis: #{axis}"
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

    @array = Array.new(8) {Array.new(8)}
    @players_turn = true    

    class << self
      attr_accessor :array, :players_turn
    end

    def initialize_pawns row_pawns, color
      Pawn.send(:img_and_color, color)
      @array[row_pawns].map!.with_index {|item, column_pawn| Pawn.piece(column_pawn, row_pawns, 80, 80, 1.0, self.class, 0)}
      p "=========**********************************1"
      p @array[row_pawns]
      p "=========**********************************2"
    end

    def initialize_officers row_officers, color, chessmans#*paths
      @array[row_officers] = chessmans.map.with_index do |chessman, column_officer|
        chessman.send(:img_and_color, color)
        chessman.piece(column_officer, row_officers, 80, 80, 1.0, self.class, 0)
      end
    end

    def is_my_piece? x, y
      # p @array[y][x].get_class
      p self.class
      !@array[y][x].nil? && @array[y][x].get_class == self.class
    end

    def is_enemy_piece? x, y
      !@array[y][x].nil? && @array[y][x].get_class != self.class
    end

    def mark_piece x, y
      if is_my_piece?(x, y)
        @show_marked_piece = @array[y][x].mark x, y
        p "mark_piece: #{@array[y][x].inspect}"
        @mark_cordinates = [y, x]
        @mark_turn = !@mark_turn
      end
    end
    
    def show_path x, y
      if is_my_piece?(x, y)
        p "show1"
        p @array[y][x].get_class
        p self.class
        p "show2"
        @path_squares = @array[y][x].path x, y
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

    def cancel_show_path x, y
      p "@path_squares: #{@path_squares}"
      @path_squares.reject(&:nil?).each(&:remove)
      @path_squares = []
      # @path_squares.compact.each(&:remove) # убрать все  nil
    end

    def make_move x, y
      if @array[y][x].nil?
        @array[y][x] = @array[@mark_cordinates[0]][@mark_cordinates[1]]
        p "@array[@mark_cordinates[0]][@mark_cordinates[1]] #{@array[@mark_cordinates[0]][@mark_cordinates[1]]}"
        @array[@mark_cordinates[0]][@mark_cordinates[1]].remove
        @array[@mark_cordinates[0]][@mark_cordinates[1]] = nil
        @array[y][x].new_coordinates x, y, 0
        @array[y][x].add
        @players_turn = !@players_turn
      end
    end

    def process_mark x, y
      mark_piece x, y
      
      show_path x, y 
    end

    def undo_mark x, y
      cancel_show_path x, y

      unmark_piece
    end

    def process_move x, y
      remove_piece x, y

      make_move x, y

      undo_mark x, y 
    end
  end
end
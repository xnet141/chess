require_relative 'board'

module Chess
  class Player
    def initialize
      @array = Array.new(8) {Array.new(8)}
      @mark = true
      @mark_piece = nil
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
      if @mark
        p "!!!!!!!!!@mark_piece: #{@mark_piece.inspect}"
        get_mark_piece x, y
        p "!!!!!!!!!@mark_piece: #{@mark_piece.inspect}"
      #end
      else #if @mark
        choose_square x, y
        p "======@mark_piece: #{@mark_piece.inspect}"
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

    def get_mark_piece x, y
      if @array[y][x].class == ImageWithArray
        # @array[y][x].remove
        @mark = !@mark
        @show_marked_piece = piece x, y, 0, 100, 100, 0.6
        @mark_piece = @array[y][x]
      end
    end

    def choose_square x, y
      p "begin @array[x][y]: #{@array[y][x].class}"
      if @array[y][x].nil?
        # @array[@mark_piece[1]][@mark_piece[0]].remove
        # @mark_piece.remove
        # p "remove @mark_piece: #{@mark_piece.inspect}"
        # @mark_piece = nil
        # p "nil @mark_piece: #{@mark_piece}"
        p "@mark_piece.data: #{@mark_piece.data}"
        
        @array[y][x] = @mark_piece
        @array[y][x].coordinates x, y, 10
        # @mark_piece.remove
        # @array[y][x].add
        # p "@@@@@ @mark_piece: #{@mark_piece.inspect}"
        @show_marked_piece.remove
        @show_marked_piece = @mark_piece = nil
        # @mark_piece.add
        @mark = !@mark
      end
      # p "end @array[x][y]: #{@array[x][y].inspect}"
    end 
  end  
end
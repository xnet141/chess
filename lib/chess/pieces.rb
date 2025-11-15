module Chess
  module Pieces
    class PieceImage < Image
      attr_accessor :get_class, :pieces_path, :img_instance  
      attr_accessor :data 
     
      def initialize(path, atlas: nil,
                    width: nil, height: nil, x: nil, y: nil, z: 0,
                    rotate: 0, color: nil, colour: nil,
                    opacity: nil, show: true, piece_name: nil, d: nil, data: nil, get_class: nil)
        super(path, atlas: atlas,
                    width: width, height: height, x: x, y: y, z: z,
                    rotate: rotate, color: color, colour: colour,
                    opacity: opacity, show: show)
        @img_instance = path
        @piece_name = piece_name
        @d = d
        @data = data
        @get_class = get_class
        @count = nil
        # @pieces_path = [] # temp_arr
        new_coordinates @data[0], @data[1], @d     
      end

      def new_coordinates x, y, d = 0
        @x = x * GRID_SIZE + GRID_SIZE + 10 + d  
        @y = y * GRID_SIZE + GRID_SIZE + 10 + d 
        @data = x, y    
      end
      
      # def []=(index, value); @data[index] = value; end

      def [](index)
        if index.is_a?(Integer) && index >= 0 && index < @data.size
          @data[index]
        else
          raise IndexError, "Неверный индекс"
        end
      end

      class << self
        attr_reader :img
      end

      def self.piece data_x, data_y, width, height, transparency, get_class = nil, d
        if (0..7).cover?(data_x) && (0..7).cover?(data_y) # метод класса
          self.new(
            @img,# ||= 'images/pawn_black.png',
              # x: x * GRID_SIZE + GRID_SIZE + hash, y: y * GRID_SIZE + GRID_SIZE + hash,
            width: width, height: height,
            color: [1.0, 1.0, 1.0, transparency],
            rotate: 0,
            z: 0,
            d: d,
            data: [data_x, data_y],
            get_class: get_class
          )
        end
      end

      def piece data_x, data_y, width, height, transparency, d
        self.class.piece data_x, data_y, width, height, transparency, d
      end # метод экземпляра

      def mark x, y
        # p "!*!*!@array: #{player}"
        piece x, y, 120, 120, 0.9, -20
      end

      def piece_for_path x, y
        piece x, y, 100, 100, 0.6, -10
      end
    end
    
    class Pawn < PieceImage
      def self.white
        @img = 'images/pawn_white.png'
      end
      
      def self.black
        @img = 'images/pawn_black.png'
      end

      def path x, y
        # p "@img_instance : #{@img_instance}"
        temp_arr = []
        if @get_class == Player1
          temp_arr << piece_for_path(x, y - 1)
          temp_arr << piece_for_path(x, y - 2)
        else
          temp_arr << piece_for_path(x, y + 1)
          temp_arr << piece_for_path(x, y + 2)
        end

        # @count += 1
        # зависит от плеера или цвета
        # первый ход у пешки - на 2 клетки вперед
        # кушает по диагонали
        # назад не ест не ходит
      end
    end
    
    class Knight < PieceImage
      def self.white
        @img = 'images/knight_white.png'
      end
      
      def self.black
        @img = 'images/knight_black.png'
      end

      def path x, y
        temp_arr = []
        arr1 = []; arr2 = []
        (0..7).cover?(y-2) ? arr1.push(y-2,y-1) : arr1.push(nil,nil)
        (0..7).cover?(y+2) ? arr1.push(y+1,y+2) : arr1.push(nil,nil)
        (0..7).cover?(x-2) ? arr2.push(x-2,x-1) : arr2.push(nil,nil)
        (0..7).cover?(x+2) ? arr2.push(x+1,x+2) : arr2.push(nil,nil)
        p "arr1 : #{arr1}"
        p "arr2 : #{arr2}"
        arr1.map.with_index do |dy, index|
          temp_arr << piece_for_path(x+1, dy) if index == 0
          temp_arr << piece_for_path(x-1, dy) if index == 0
          temp_arr << piece_for_path(x, dy)
          temp_arr << piece_for_path(x+1, dy) if index == 3
          temp_arr << piece_for_path(x-1, dy) if index == 3
        end
        arr2.map.with_index do |dx, index|
          temp_arr << piece_for_path(dx, y+1) if index == 0
          temp_arr << piece_for_path(dx, y-1) if index == 0
          temp_arr << piece_for_path(dx, y)
          temp_arr << piece_for_path(dx, y+1) if index == 3
          temp_arr << piece_for_path(dx, y-1) if index == 3
        end
        temp_arr # нужна ли эта переменная, неплохо бы переменную с ходами или базу
      end
    end

    class Rook < PieceImage
      def self.white
        @img = 'images/rook_white.png'
      end
      
      def self.black
        @img = 'images/rook_black.png'
      end

      def path x, y
        temp_arr = []
        7.times do |i|
          i += 1
          y1 = y + i
          y2 = y - i   
          x1 = x + i
          x2 = x - i

          temp_arr << piece_for_path(x, y1) if (0..7).cover?(y1)
          temp_arr << piece_for_path(x, y2) if (0..7).cover?(y2)
          temp_arr << piece_for_path(x1, y) if (0..7).cover?(x1)
          temp_arr << piece_for_path(x2, y) if (0..7).cover?(x2)
        end
        temp_arr
      end
    end

    class Bishop < PieceImage
      def self.white
        @img = 'images/bishop_white.png'
      end
      
      def self.black
        @img = 'images/bishop_black.png'
      end

      def path x, y
        temp_arr = []
        7.times do |i|
          i += 1
          y1 = y + i
          y2 = y - i   
          x1 = x + i
          x2 = x - i

          temp_arr << piece_for_path(x1, y1) if (0..7).cover?(x1) && (0..7).cover?(y1)
          temp_arr << piece_for_path(x2, y2) if (0..7).cover?(x2) && (0..7).cover?(y2)
          temp_arr << piece_for_path(x1, y2) if (0..7).cover?(x1) && (0..7).cover?(y2)
          temp_arr << piece_for_path(x2, y1) if (0..7).cover?(x2) && (0..7).cover?(y1) 
        end
        temp_arr
      end
    end

    class Queen < PieceImage
      def self.white
        @img = 'images/queen_white.png'
      end
      
      def self.black
        @img = 'images/queen_black.png'
      end

      def path x, y
        temp_arr = []
        7.times do |i|
          i += 1
          y1 = y + i
          y2 = y - i   
          x1 = x + i
          x2 = x - i

          temp_arr << piece_for_path(x, y1) if (0..7).cover?(y1)
          temp_arr << piece_for_path(x, y2) if (0..7).cover?(y2)
          temp_arr << piece_for_path(x1, y) if (0..7).cover?(x1)
          temp_arr << piece_for_path(x2, y) if (0..7).cover?(x2)
          temp_arr << piece_for_path(x1, y1) if (0..7).cover?(x1) && (0..7).cover?(y1)
          temp_arr << piece_for_path(x2, y2) if (0..7).cover?(x2) && (0..7).cover?(y2)
          temp_arr << piece_for_path(x1, y2) if (0..7).cover?(x1) && (0..7).cover?(y2)
          temp_arr << piece_for_path(x2, y1) if (0..7).cover?(x2) && (0..7).cover?(y1) 
        end
        temp_arr
      end
    end

    class King < PieceImage
      def self.white
        @img = 'images/king_white.png'
      end
    
      def self.black
        @img = 'images/king_black.png'
      end

      def path x, y
        temp_arr = []
        temp_arr << piece_for_path(x, y + 1)
        temp_arr << piece_for_path(x, y - 1)
        temp_arr << piece_for_path(x + 1, y)
        temp_arr << piece_for_path(x - 1, y)
        temp_arr << piece_for_path(x + 1, y + 1)
        temp_arr << piece_for_path(x - 1, y - 1)
        temp_arr << piece_for_path(x + 1, y - 1)
        temp_arr << piece_for_path(x - 1, y + 1)
        # temp_arr
      end
    end
  end
end
module Chess
  module Pieces
    class PieceImage < Image
      attr_reader :piece_name, :img, :get_class  
      attr_accessor :data 

      def initialize(path, atlas: nil,
                    width: nil, height: nil, x: nil, y: nil, z: 0,
                    rotate: 0, color: nil, colour: nil,
                    opacity: nil, show: true, piece_name: nil, d: nil, data: nil, get_class: nil)
        super(path, atlas: atlas,
                    width: width, height: height, x: x, y: y, z: z,
                    rotate: rotate, color: color, colour: colour,
                    opacity: opacity, show: show)
        @img = path
        @path = []
        @piece_name = piece_name
        @d = d
        @data = data
        @get_class = get_class
        new_coordinates @data[0], @data[1], @d     
      end

      def new_coordinates x, y, d = 0
        @x = x * GRID_SIZE + GRID_SIZE + 10 + d  
        @y = y * GRID_SIZE + GRID_SIZE + 10 + d 
        @data = x, y    
      end
      # def []=(index, value)
      #   @data[index] = value
      # end
      def [](index)
        if index.is_a?(Integer) && index >= 0 && index < @data.size
          @data[index]
        else
          raise IndexError, "Неверный индекс"
        end
      end
    end

    class Pawn < PieceImage
      def path
        
      end
    end

    class Knight < PieceImage
      def path array, x, y
        arr1 = []; arr2 = []
        (0..7).cover?(y-2) ? arr1.push(y-2,y-1) : arr1.push(nil,nil)
        (0..7).cover?(y+2) ? arr1.push(y+1,y+2) : arr1.push(nil,nil)
        (0..7).cover?(x-2) ? arr2.push(x-2,x-1) : arr2.push(nil,nil)
        (0..7).cover?(x+2) ? arr2.push(x+1,x+2) : arr2.push(nil,nil)
        p "arr1 : #{arr1}"
        p "arr2 : #{arr2}"
        # hash = {"Player1" => [y-2,y-1,y+1,y+2]}#, ,y-2 "Player2" => [y+1,y+2,y+2]}
        arr1.map.with_index do |dy, index|
          @path_squares << piece_for_path(self.class, array[y][x].img, x+1, dy) if index == 0
          @path_squares << piece_for_path(self.class, array[y][x].img, x-1, dy) if index == 0
          @path_squares << piece_for_path(self.class, array[y][x].img, x, dy)
          @path_squares << piece_for_path(self.class, array[y][x].img, x+1, dy) if index == 3
          @path_squares << piece_for_path(self.class, array[y][x].img, x-1, dy) if index == 3
        end
        arr2.map.with_index do |dx, index|
          @path_squares << piece_for_path(self.class, array[y][x].img, dx, y+1) if index == 0
          @path_squares << piece_for_path(self.class, array[y][x].img, dx, y-1) if index == 0
          @path_squares << piece_for_path(self.class, array[y][x].img, dx, y)
          @path_squares << piece_for_path(self.class, array[y][x].img, dx, y+1) if index == 3
          @path_squares << piece_for_path(self.class, array[y][x].img, dx, y-1) if index == 3
        end
      end
      
      def piece_for_path chessman, img, x, y
        piece chessman, img, x, y, 100, 100, 0.6, -10
      end
    end
  end
end
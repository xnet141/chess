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
      
    end

    class Knight < PieceImage
      
    end
  end
end
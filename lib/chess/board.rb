module Chess  
  module Board
    class CircleWithArray < Circle
      def initialize(x: 25, y: 25, z: 0, radius: 50, sectors: 30,
                    color: nil, colour: nil, opacity: nil, data: nil)
        super(x: x, y: y, z: z, radius: radius, sectors: sectors,
              color: color, colour: colour, opacity: opacity)
        
        @data = data
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

    class ImageWithArray < Image
      def initialize(path, atlas: nil,
                    width: nil, height: nil, x: 0, y: 0, z: 0,
                    rotate: 0, color: nil, colour: nil,
                    opacity: nil, show: true, data: nil)
        super(path, atlas: atlas,
                    width: width, height: height, x: x, y: y, z: z,
                    rotate: rotate, color: color, colour: colour,
                    opacity: opacity, show: show)
        @data = data
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

    def axis event_x, event_y # попробовать улучшить
      raws_and_columns = Array.new(8) { |j|
                            Array.new(2) { |i|
                              i == 0 ? (j+1)*100...((j+1)+1)*100 : [(j + 97).chr, 8 - j] 
                            }
                          }
      #raise            
      raw = get_raw_or_column(raws_and_columns, event_x) # [0]
      column = get_raw_or_column(raws_and_columns, event_y ) # [1]
      return if (raw && column) == nil 
      [raw[0], column[1]]
    end # nil

    def get_raw_or_column arr, event
      raw_or_column = arr.select do |range, raw_or_column| # зачем to_h , to_a
        range.include?(event)
      end
      p raw_or_column
      return if raw_or_column.size == 0
      raw_or_column[0][1]
    end
  end
end
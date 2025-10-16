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
      raw_x = Array.new(11) { |j| Array.new(2) { |i| i == 0 ? (j*100..(j+1)*100) : (j + 97).chr }}  # 0..100 => 0, 100..200 => 1, ...
      column_y = Array.new(11) { |j| Array.new(2) { |i| i == 0 ? (j*100..(j+1)*100) : j }}  # 0..100 => 0, 100..200 => 1, ...

      [get_raw_or_column(raw_x, event_x)[0][1], get_raw_or_column(column_y, event_y)[0][1]]
    end

    def get_raw_or_column arr, event
      arr.select do |key, value| # зачем to_h , to_a
        key.include?(event)
      end
    end
  end
end
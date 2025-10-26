module Chess  
  module Board

    private

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
      attr_reader :path 
      attr_accessor :data 
      # attr_accessor :color

      def initialize(path, atlas: nil,
                    width: nil, height: nil, x: nil, y: nil, z: 0,
                    rotate: 0, color: nil, colour: nil,
                    opacity: nil, show: true, d: nil, data: nil)
        super(path, atlas: atlas,
                    width: width, height: height, x: x, y: y, z: z,
                    rotate: rotate, color: color, colour: colour,
                    opacity: opacity, show: show)
        @path = path
        @data = data
        @d = d
        new_coordinates @data[0], @data[1], @d     
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

      def new_coordinates x, y, d = 0
        @x = x * GRID_SIZE + GRID_SIZE + d  
        @y = y * GRID_SIZE + GRID_SIZE + d
        @data = x, y    
      end
    end

    def axis event_x, event_y # попробовать улучшить
      ranks_files_raws_columns = Array.new(8) { |j|
                            Array.new(2) { |i|
                              i == 0 ? (j+1)*100...((j+1)+1)*100 : [(j + 97).chr, 8 - j, j] 
                            }
                          }
      #raise            
      file = get_rank_file_raw_column(ranks_files_raws_columns, event_x)
      rank = get_rank_file_raw_column(ranks_files_raws_columns, event_y)
      column = file
      raw = rank
      p "===============rank... #{rank.inspect}"
      return if [raw, column, rank, file].any?(&:nil?)
      [file[0], rank[1], column[2], raw[2]]
    end # nil

    def get_rank_file_raw_column arr, event
      rank_file_raw_column = arr.select do |range, rank_file_raw_column| # зачем to_h , to_a
        range.include?(event)
      end
      p "===rank_file... #{rank_file_raw_column}"
      return if rank_file_raw_column.size == 0
      rank_file_raw_column[0][1]
    end
  end
end
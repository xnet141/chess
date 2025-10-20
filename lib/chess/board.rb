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
      ranks_files_raws_columns = Array.new(8) { |j|
                            Array.new(2) { |i|
                              i == 0 ? (j+1)*100...((j+1)+1)*100 : [(j + 97).chr, 8 - j, j] 
                            }
                          }
      #raise            
      rank = get_rank_file_raw_column(ranks_files_raws_columns, event_x)
      files = get_rank_file_raw_column(ranks_files_raws_columns, event_y)
      raw = get_rank_file_raw_column(ranks_files_raws_columns, event_x)
      column = get_rank_file_raw_column(ranks_files_raws_columns, event_y)

      return if [raw, column, rank, files].any?(&:nil?)
      [rank[0], files[1], raw[2], column[2]]
    end # nil

    def get_rank_file_raw_column arr, event
      get_rank_file_raw_column = arr.select do |range, ranks_files_raws_columns| # зачем to_h , to_a
        range.include?(event)
      end
      p get_rank_file_raw_column
      return if get_rank_file_raw_column.size == 0
      get_rank_file_raw_column[0][1]
    end
  end
end
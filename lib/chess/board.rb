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

    
    # class PieceImage < Image


    def axis event_x, event_y # попробовать улучшить
      ranks_files_rows_columns = Array.new(8) { |j|
                            Array.new(2) { |i|
                              i == 0 ? (j+1)*100...((j+1)+1)*100 : [(j + 97).chr, 8 - j, j] 
                            }
                          }
      #raise            
      file = get_rank_file_row_column(ranks_files_rows_columns, event_x)
      rank = get_rank_file_row_column(ranks_files_rows_columns, event_y)
      column = file
      row = rank
      p "===============rank... #{rank.inspect}"
      return if [row, column, rank, file].any?(&:nil?)
      [file[0], rank[1], column[2], row[2]]
    end # nil

    def get_rank_file_row_column arr, event
      rank_file_row_column = arr.select do |range, rank_file_row_column| # зачем to_h , to_a
        range.cover?(event)
      end
      p "===rank_file... #{rank_file_row_column}"
      return if rank_file_row_column.size == 0
      rank_file_row_column[0][1]
    end
  end
end
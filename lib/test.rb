# hh = {0..199 => 0, 200..399 => 1, 400..600 => 2}

# count = 105
# array = []
# hash = Hash.new

# array1 = (0..1000).step(100).to_a 
# p array1

# array2 = Array.new(11) { |i| i*100 }
# p array2

# array3 = Array.new(8) { |j|
#                             Array.new(2) { |i|
#                               i == 0 ? (j+1)*100...((j+1)+1)*100 : [(j + 97).chr, 8 - j] 
#                             }
#                           }.to_h # .to_h   0..100 => 0, 100..200 => 1, 200..300 => 2, 300..400 => 3, 400..500 => 4, 500..600 => 5, 600..700 => 6, 700..800 => 7, 800..900 => 8, 900..1000 => 9, 1000..1100 => 10}
# p array3

# counters = Array.new(3) { Hash.new(0) }
# p counters

array = [[5,3,7,9,9],[2,6,3,9,7]]
def initialize_board array
  [0, 1].each.with_index do |raw, y|
    p raw.class
    # arr = array[raw].clone
    array[raw].map!.with_index do |column_item, x| # map
      p column_item
      column_item = 42
      p column_item
    end
  end
end

initialize_board array
p array

# test


require 'ruby2d'

set title: "Hello Triangle"
# s = Square.new(x: 10, y: 10, size: 100)
array = Array.new(6)
x = 0
array.map! do |item|
  puts
  item = Square.new(x: x, y: 10, size: 100)
  x += 101
  item
  # s.x += 101
end
# s.add

# p array.inspect

array.each do |item|
  puts item.inspect
  puts
end

var1 = 0
var2 = 0
var3 = 0
var4 = 0
on :mouse_down do |event| 
  case event.button
  when :left
    var1 = array[1]
    var2 = array[2]
    var3 = array[3]
    var4 = array[4]

    # p var
    array[1..4].each(&:remove) unless array[1..4].any?(&:nil?) # супер тема
    # array[1].remove unless array[1].nil?
    # array[2].remove unless array[2].nil?
    # array[3].remove unless array[3].nil?
    # array[4].remove unless array[4].nil?
    # array[1..4] = [nil] * 4
    array.fill(nil, 1..4) # супер тема
    # p array[1]
    p "============="
    p array
  when :right
    array[1..4] = [var1, var2, var3, var4] # супер тема
    # array[2] = var2 
    # array[3] = var3 
    # array[4] = var4 
    array[1..4].each(&:add) # супер тема
    # array[1].add 
    # array[2].add 
    # array[3].add 
    # array[4].add 
    # p var
    p "============="
    p array
  end
end

show

# class T
#   def initialize a: nil, b: nil, c: nil
#     @a = a
#     @b = c

#   end
# end

# t = T.new a: 11 ,b: 12, c: [1, 22]  
# p t.inspect
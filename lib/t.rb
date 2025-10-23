require 'ruby2d'

set title: "Hello Triangle"

s = Square.new(x: 50, y: 50, size: 100)
s.x = 300
s.y = 100


on :mouse_down do |event| 
  case event.button
  when :left
    s.x += 20
  when :right
    close
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
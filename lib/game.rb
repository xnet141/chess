require 'ruby2d'
require_relative 'chess/players'


set title: "Hello!"

GRID_SIZE = 100
WIDTH = 10 
HEIGHT = 10
# GRID_COLOR = Color.new('#222222')
# BLOCK_COLOR = Color.new(['orange', 'yellow', 'green'].sample)

set width: WIDTH * GRID_SIZE
set height: HEIGHT * GRID_SIZE

# (0..Window.width).step(GRID_SIZE).each do |x|
#   Line.new(x1: x, x2: x, y1: 0, y2: Window.height, width: 2, color: GRID_COLOR, z: 1)
# end

# (0..Window.height).step(GRID_SIZE).each do |y|
#   Line.new(y1: y, y2: y, x1: 0, x2: Window.width, width: 2, color: GRID_COLOR, z: 1)
# end
Image.new(
  'images/chess2.png',
  x: 0, y: 0,
  width: 1000, height: 1000,
  color: [1.0, 1.0, 1.0, 1.0],
  rotate: 0,
  z: 0,
)
  
player1 = Chess::Player1.new
player2 = Chess::Player2.new
  
t = nil
on :mouse_down do |event| 
  case event.button
  when :left
    t.remove unless t.nil?
    if Chess::Logic.players_turn
      player1.logic event.x, event.y
      p "player1.players_turn: #{player1.players_turn}"
      p "player2.players_turn: #{player2.players_turn}"
    else
      p "player1.players_turn: #{player1.players_turn}"
      player2.logic event.x, event.y
      p "player1.players_turn: #{player1.players_turn}"
      p "player2.players_turn: #{player2.players_turn}"
    end
    t = Text.new(
      "player1.count: #{player1.count}, player2.count: #{player2.count}",
      x: 40, y: 936,
      font: 'fonts/LiberationSerif-Regular.ttf',
      style: 'bold',
      size: 35,
      color: 'blue',
      rotate: 0,
      z: 10
    )
  when :right
    puts "player1.count: #{player1.count}"
    puts "player2.count: #{player2.count}"
    close
  end
end


show
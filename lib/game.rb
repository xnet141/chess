require 'ruby2d'
require_relative 'chess/player'


set title: "Hello!"

GRID_SIZE = 105.5
WIDTH = 10 
HEIGHT = 10
GRID_COLOR = Color.new('#222222')
BLOCK_COLOR = Color.new(['orange', 'yellow', 'green'].sample)

set width: WIDTH * GRID_SIZE
set height: HEIGHT * GRID_SIZE

(78..Window.width).step(GRID_SIZE).each do |x|
  Line.new(x1: x, x2: x, y1: 0, y2: Window.height, width: 2, color: GRID_COLOR, z: 1)
end

(78..Window.height).step(GRID_SIZE).each do |y|
  Line.new(y1: y, y2: y, x1: 0, x2: Window.width, width: 2, color: GRID_COLOR, z: 1)
end

Image.new(
      'desk.png',
      x: 0, y: 0,
      width: 1000, height: 1000,
      color: [1.0, 1.0, 1.0, 1.0],
      rotate: 0,
      z: 0,
    )

player = Chess::Player.new

on :mouse_down do |event| 
  case event.button
  when :left
    # puts event.x, event.y
    p player.axis event.x, event.y
  when :right
    close
  end
end


show

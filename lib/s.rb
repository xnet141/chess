# @a = nil

# def aa
#   @a = 2
# end

# p @a

# if aa
# else
#   p "!!!!!!!"
# end

# p @a

# def test a, *mes
# p a
# p "===="
# p mes
# p mes.inspect
# end

# test 112, "test", 43, 54

# def par a, b: nil, alex
#   p a
#   p b
# end

# par 1

# (1..3).map {|item_x| p item_x}

# arr = []
# @qwqw = nil
# def plus
#   @qwqw = 42
# end
# p @qwqw
# arr.push(22)
# arr.push(12)

# arr << if plus
#         #  plus 
#         end
# arr.push(if plus; plus; end)
# p arr
# p "=" * 7
# p @qwqw

# class Player1
#   def initialize var = nil , a: nil, b: nil
#     @a = a
#     @b = b
#     @c = var
#   end
# end

# def knight_path player
#   hh = {Player1 => [42, 72]}
#   hh[player]
#   p hh
# end

# p knight_path Player1

# p "===="

# test_puts = p "some"
# p test_puts
# puts test_puts.inspect


# p Player1.to_s

# test = Player1.new b: 42
# p test


# def testing a, b = nil, c = 222222, d = 33333, e
#   p a
#   p b
#   p c
#   p d
#   p e
# end

# testing 1, 2, 3, 4
p "==="

class Polka
  @a = "Alex - superdev"
    class << self
      attr_accessor :a
    end
  def self.aaa
    p @a * 3
  end
  def get_a
    self.class.a
  end
end
# p Polka.a
# p Polka.aaa
# p Polka.methods

p Polka.new.get_a
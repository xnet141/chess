module Test
  class Trest
    Test.const_set(:Pawn, Class.new(Trest))
  end
  
  p Test::Pawn.superclass
  
  class Pawn
    def alex
      puts "Hi from alex"
    end
  end
end
  
Test::Pawn.new.alex

# class User
#   def register(name, email, *roles, active: true, **metadata, &setup)
#     puts "Имя: #{name}"
#     puts "Email: #{email}"
#     puts "Роли: #{roles.join(', ')}"
#     puts "Активен: #{active}"
#     puts "Метаданные: #{metadata}"

#     # if block_given?
#       setup.call(self)
#       puts "Настройка завершена"
#     # end
#   end
# end

# user = User.new
# user.register(
#   "Мария",
#   "maria@example.com",
#   "admin", "editor",
#   active: false,
#   department: "HR",
#   team: "A"
# ) do |u|
#   puts "Выполняем дополнительные действия для #{u}"
# end

# p "==!!== dy, dx #{dy}, #{dx}===!!==="


# def wh y
#   yield y
# end

# wh(0) {|var|
#   while var <= 7 do
#     var +=1class
  # end
#     p var
#   end
# }

class T
  IMG = "const"
  @a = 10
  @@bb = 333
  def self.get_a
    p @a
  end
  def self.get_bb
    p @@bb
  end
  def get_bb
    p @@bb
  end
  def self.get_const
    p IMG
  end  
  def get_const
    p IMG
  end
  def self.get_class
    p self.to_s.to_sym
  end
end

class Son < T
  @a = 22
  # def self.get_a
  #   p @a
  # end
end

class Child < Son
  @@bb = 666666
end


T.get_a
T.get_bb
T.new.get_bb
p "=" * 22
Son.get_a
Son.get_bb
Son.new.get_bb
p "=" * 22
T.get_a
T.get_bb
T.new.get_bb
p "=" * 22
Child.get_a
Child.get_bb
Child.new.get_bb

Child.get_const
p Child::IMG
child = Child.new
child.get_const
p child.class::IMG
Child.get_class
p Child.name
p Child.to_s





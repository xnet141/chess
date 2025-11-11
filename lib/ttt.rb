
class User
  def register(name, email, *roles, active: true, **metadata, &setup)
    puts "Имя: #{name}"
    puts "Email: #{email}"
    puts "Роли: #{roles.join(', ')}"
    puts "Активен: #{active}"
    puts "Метаданные: #{metadata}"

    # if block_given?
      setup.call(self)
      puts "Настройка завершена"
    # end
  end
end

user = User.new
user.register(
  "Мария",
  "maria@example.com",
  "admin", "editor",
  active: false,
  department: "HR",
  team: "A"
) do |u|
  puts "Выполняем дополнительные действия для #{u}"
end
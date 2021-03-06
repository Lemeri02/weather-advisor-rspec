require_relative 'lib/garment'
require_relative 'lib/wardrobe'
require_relative 'lib/garment-adder'

file_path = Dir["#{__dir__}/data/*.txt"]
wardrobe = Wardrobe.get_garment(file_path)

puts 'Сколько градусов за окном? (можно с минусом)'

selected_garment = wardrobe.select_garment_by_type(STDIN.gets.to_i)

if selected_garment.empty?
  puts 'Не найдено ничего подходящего! Пополните гардероб!'
else
  puts 'Предлагаем сегодня надеть:'
  puts selected_garment
end

puts 'Пополнить гардероб? (1 - "Да", Любой символ или Enter - "Нет")'

user_input = STDIN.gets.to_i

if user_input == 1
  puts "Введите название шмотки (Вот что имеется у вас: #{wardrobe.names.join(', ')})."
  garment_name = STDIN.gets.chomp

  if wardrobe.include_garment?(garment_name)
    puts 'У вас уже есть такая шмотка'
  else
    puts "Введите тип шмотки (например, уже имеющиеся: #{wardrobe.types.join(', ')})"
    garment_type = STDIN.gets.chomp

    puts 'Введите первую температуру (например: +20 или -30 )'
    temp_first = STDIN.gets.to_i

    puts 'Введите вторую температуру (например: +20 или -30 )'
    temp_last = STDIN.gets.to_i

    GarmentAdder.add_garment(
      name: garment_name,
      type: garment_type,
      temp_range: [temp_first, temp_last].sort,
      wardrobe: wardrobe
    )
    puts 'Гардероб пополнен'
  end
end

puts 'Удачи!'

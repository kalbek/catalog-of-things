require_relative 'item'

def run
  puts 'Welcome to catalog of things!!'
  loop do
    display_menu
    print "\nEnter your choice: "
    choice = gets.chomp
    if %w[1 5 7].include?(choice)
      book_options(choice)
    elsif %w[2 4 8].include?(choice)
      music_options(choice)
    elsif %w[3 6 9].include?(choice)
      game_options(choice)
    elsif choice == '0'
      puts 'Thank you for using this app!'
      exit!
    else
      puts 'Invalid input!'
    end
  end
end

def book_options(_choice)
  puts 'running books options'
end

def music_options(_choice)
  puts 'running music options'
end

def game_options(_choice)
  puts 'running game options'
end

def display_menu
  puts "\n"
  puts 'Please make your choice:'
  puts '1 - List all books' # books
  puts '2 - List all music albums' # music
  puts '3 - List of games' # games
  puts "4 - List all genres (e.g 'Comedy', 'Thriller')" # music
  puts "5 - List all labels (e.g. 'Gift', 'New')" # books
  puts "6 - List all authors (e.g. 'Stephen King')" # games
  puts '7 - Add a book' # books
  puts '8 - Add a music album' # music
  puts '9 - Add a game' # games
  puts '0 - Quit'
end
run

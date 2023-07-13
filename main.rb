require_relative 'item'
# require_relative 'book'
require_relative 'game'
require_relative 'author'
require_relative 'music_album'

def run
  puts 'Welcome to catalog of things!!'
  loop do
    display_menu
    print "\nEnter your choice: "
    choice = valid_integer_input
    case choice
    when 1, 5, 7, 0
      book_options(choice)
    when 2, 4, 8
      music_options(choice)
    when 3, 6, 9
      game_options(choice)
    else
      puts 'Invalid input!'
    end
  end
end

def valid_integer_input
  input = gets.chomp
  Integer(input)
rescue ArgumentError
  nil
end

def book_options(choice)
  case choice
  when 1
    puts '1 - List all books' # books
  when 5
    puts "5 - List all labels (e.g. 'Gift', 'New')" # books
  when 7
    Book.add_a_book
  when 0
    puts 'Thank you for using this app!'
    exit!
  end
end

def music_options(choice)
  case choice
  when 2
    MusicAlbum.list_music_albums
  when 4
    puts "4 - List all genres (e.g 'Comedy', 'Thriller')" # music
    Genre.list_all_genres
  when 8
    puts '8 - Add a music album' # music
    MusicAlbum.add_album
  when 0
    puts 'Thank you for using this app!'
    exit!
  end
end

def game_options(choice)
  case choice
  when 3
    Game.list_all_games
  when 6
    Author.list_all_authors
  when 9
    Game.add_a_game
  end
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

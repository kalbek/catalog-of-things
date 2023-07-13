require_relative 'item'
require_relative 'author'
require 'date'
require 'json'

class Game < Item
  attr_accessor :multiplayer, :last_played_at, :author
  attr_reader :id

  def initialize(id, multiplayer, last_played_at, publish_date)
    super(id, publish_date, false)
    @id = id || Random.rand(1..100)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @publish_date = publish_date
    @author = author
  end

  # def add_item(item)
  #   item.author = author
  # end

  def add_item(item)
    item.author = self.author
  end


  def self.validate_date
    date_input = gets.chomp

    begin
      Date.parse(date_input)
    rescue ArgumentError
      puts 'Invalid date! Please enter a valid date.'
      validate_date
    end
  end

  def self.game_details
    game_data = {
      multiplayer: false,
      last_played_at: '',
      publish_date: Date.today,
      author_firstname: '',
      author_lastname: ''
    }

    print 'Is the game multiplayer? (true/false): '
    game_data[:multiplayer] = gets.chomp.downcase == 'true'

    print 'Enter the last played date (YYYY-MM-DD): '
    game_data[:last_played_at] = validate_date

    print 'Enter the published date (YYYY-MM-DD): '
    game_data[:publish_date] = validate_date

    print 'Enter the author_firstname: '
    game_data[:author_firstname] = gets.chomp

    print 'Enter the author_lastname: '
    game_data[:author_lastname] = gets.chomp

    game_data
  end

  def self.add_a_game
    game_data = game_details
    loaded_games = load_games_data

    data = update_loaded_data(game_data, loaded_games)
    game = data[:game]
    author = data[:author]
    loaded_games = data[:loaded_games]
    loaded_authors = data[:loaded_authors]

    add_game_item_to_list(game_data, game, author)

    save_games_to_json(loaded_games)
    author.save_authors_to_file(loaded_authors)
  end

  def self.add_game_item_to_list(game_data, _game, author)
    items = if File.exist?('items.json') && !File.empty?('items.json')
              JSON.parse(File.read('items.json'), symbolize_names: true)
            else
              []
            end

    item = Item.new(items.length + 1, game_data[:publish_date], false)
    item.author = author
    author.add_item(item)
    puts 'Game added successfully!'
  end

  def self.update_loaded_data(game_data, loaded_games)
    loaded_authors = Author.load_authors_data

    author = Author.new(loaded_authors.length + 1, game_data[:author_firstname], game_data[:author_lastname])
    game = Game.new(loaded_games.length + 1, game_data[:multiplayer], game_data[:last_played_at],
                    game_data[:publish_date])
    loaded_authors << author
    loaded_games << game

    {
      game: game,
      author: author,
      loaded_authors: loaded_authors,
      loaded_games: loaded_games
    }
  end

  def self.save_games_to_json(games)
    data = games.map do |game|
      {
        'id' => game.id,
        'multiplayer' => game.multiplayer,
        'last_played_at' => game.last_played_at,
        'publish_date' => game.publish_date.strftime('%Y-%m-%d')
      }
    end

    File.write('games.json', JSON.pretty_generate(data))
  end

  def self.load_games_data
    game_data = []

    if File.exist?('games.json') && !File.empty?('games.json')
      begin
        game_data = JSON.parse(File.read('games.json'))
      rescue JSON::ParserError => e
        puts "Error parsing 'games.json': #{e.message}"
      end
    else
      puts "File 'games.json' does not exist or is empty."
    end

    game_data.map do |data|
      publish_date = data['publish_date'] ? Date.parse(data['publish_date']) : Date.today
      game = Game.new(data['id'], data['multiplayer'], data['last_played_at'], publish_date)
      game
    end
  end

  def self.list_all_games
    game_data = load_games_data
    game_data.each do |game|
      puts "ID: #{game.id}, Multiplayer: #{game.multiplayer}, Last Played At: #{game.last_played_at}, " \
           "Published Date: #{game.publish_date}"
    end
  end
end

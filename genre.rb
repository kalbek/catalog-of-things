require_relative 'item'
require_relative 'music_album'
require 'date'

class Genre < Item
  attr_accessor :name
  attr_reader :id, :items

  def initialize(id, publish_date, name, items = [])
    super(id, publish_date, false)
    @id = id || Random.rand(1..100)
    @name = name
    @items = items
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  def self.add_genre(genre)
    updated = false
    genres = load_genres
    # should not add a simillar genre
    genres_update = genres.map do |each|
      if each.name == genre.items[0].genre.name
        each.items << genre.items[0]
        updated = true
      end
      each
    end
    if updated
      save_genres_to_file(genres_update)
    else
      genres << genre
      save_genres_to_file(genres)
    end
  end

  def self.list_all_genres
    puts "\n|-------All Genres-------|\n\n"
    genres = load_genres
    puts 'No genres added.' if genres.empty?
    genres.each do |genre|
      result = "ID: #{genre.id}, "
      result += "Date: #{genre.publish_date}, "
      result += "Genre: #{genre.name}"
      puts result
    end
  end

  def self.to_hash(arr)
    arr.map do |each|
      {
        id: each.id,
        date: each.publish_date,
        archived: each.archived,
        on_spotify: each.on_spotify
      }
    end
  end

  def self.save_genres_to_file(genres)
    data = genres.map do |genre|
      hashed = to_hash(genre.items)
      {
        id: genre.id,
        date: genre.publish_date,
        name: genre.name,
        items: hashed
      }
    end
    File.write('genres.json', JSON.pretty_generate(data))
  end

  def self.load_genres
    return [] unless File.exist?('genres.json') && !File.empty?('genres.json')

    genres_data = JSON.parse(File.read('genres.json'))
    genres_data.map do |data|
      items_arr = data['items'].map do |each|
        MusicAlbum.new(each['id'], Date.parse(each['date']), each['on_spotify'])
      end
      Genre.new(data['id'], data['date'], data['name'], items_arr)
    end
  end
end

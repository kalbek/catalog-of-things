require_relative 'item'
require_relative 'genre'
require 'date'
require 'json'

class MusicAlbum < Item
  attr_accessor :on_spotify
  attr_reader :id

  def initialize(id, publish_date, on_spotify)
    super(id, publish_date, false)
    @on_spotify = false || on_spotify
    update_archived_status
  end

  def update_archived_status
    @archived = can_be_archived?
  end

  def self.validate_date
    date_input = gets.chomp

    begin
      Date.parse(date_input)
    rescue ArgumentError
      print 'Invalid date! Enter valid date: '
      validate_date
    end
  end

  def self.types
    {
      0 => 'Pop',
      1 => 'Rock',
      2 => 'Hip Hop',
      3 => 'Dance/Electronic',
      4 => 'R&B',
      5 => 'Country',
      6 => 'Acoustic',
      7 => 'Classical',
      8 => 'Metal',
      9 => 'Jazz',
      10 => 'Blues'
    }
  end

  def self.list_genres
    puts "\n|--------List of Genres--------|\n\n"
    genres = types
    genres.keys.each do |key|
      puts "#{key}: #{genres[key]}"
    end
    print "\nChoose a genre by index(e.g 0 / 1 / 2):"
    choice = gets.chomp.to_i
    return genres[choice] if genres.keys.include?(choice)

    puts 'Please enter a valid choice!'
    list_of_genres
  end

  def self.album_details
    genre = list_genres
    print 'Is it on spotify?(y/n): '
    ans = gets.chomp
    print 'Enter date(yyyy/mm/dd): '
    date = validate_date
    id = load_albums.length + 1

    {
      id: id,
      on_spotify: %w[yes YES Yes y Y].include?(ans),
      date: date,
      genre_name: genre
    }
  end

  def self.add_album
    details = album_details
    id = details[:id]
    date = details[:date]
    name = details[:genre_name]
    on_spotify = details[:on_spotify]

    album = MusicAlbum.new(id, date, on_spotify)
    genre = Genre.new(id, date, name)
    album.genre = genre
    genre.add_item(album)
    Genre.add_genre(genre)

    save_album(album)
  end

  def self.save_album(album)
    albums = load_albums
    albums << album
    save_albums_to_file(albums)
  end

  def self.save_albums_to_file(albums)
    data = albums.map do |album|
      {
        id: album.id,
        publish_date: album.publish_date,
        on_spotify: album.on_spotify,
        genre: {
          id: album.genre.id,
          name: album.genre.name,
          date: album.genre.publish_date
        }
      }
    end
    File.write('albums.json', JSON.pretty_generate(data))
  end

  def self.load_albums
    return [] unless File.exist?('albums.json') && !File.empty?('albums.json')

    albums_data = JSON.parse(File.read('albums.json'))
    albums_data.map do |data|
      album = MusicAlbum.new(data['id'], Date.parse(data['publish_date']), data['on_spotify'])
      genre = Genre.new(data['genre']['id'], data['genre']['date'], data['genre']['name'])
      album.genre = genre
      genre.add_item(album)
      album
    end
  end

  def self.list_music_albums
    puts "\n|-------All Albumbs-------|\n\n"
    albums = load_albums
    puts 'No albums added.' if albums.empty?
    albums.each do |album|
      result = "ID: #{album.id}, "
      result += "Date: #{album.publish_date}, "
      result += "Genre: #{album.genre.name}, "
      result += "Archived: #{album.archived ? 'Yes' : 'No'}, "
      result += "On_Spotify: #{album.on_spotify ? 'Yes' : 'No'}"
      puts result
    end
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end

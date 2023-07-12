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

  def self.get_album_details
    puts 'Enter genre (e.g "Comedy", "Thriller"): '
    genre = gets.chomp
    puts 'Is it on spotify?(y/n): '
    ans = gets.chomp
    puts 'Enter date: '
    date = validate_date
    saved_albums = load_albums
    id = load_albums.length + 1

    details = {
      id: id,
      on_spotify: ans == 'yes' || ans == 'y' ? true : false,
      date: date,
      genre_name: genre
    }
    details
  end

  def self.add_album
    album_details = get_album_details
    id = album_details[:id]
    date = album_details[:date]
    name = album_details[:genre_name]
    on_spotify = album_details[:on_spotify]

    album = MusicAlbum.new(id, date, on_spotify)
    genre = Genre.new(id, date, name)
    album.genre = genre
    genre.add_item(album)

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
    return [] unless File.exist?('albums.json') && !File.zero?('albums.json')

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
    puts "|-------All Albumbs-------|\n"
    albums = load_albums
    puts "No albums added." if albums.empty?
    albums.each do |album|
      puts "ID: #{album.id}, Date: #{album.publish_date}, Genre: #{album.genre.name}, Archived: #{album.archived ? 'Yes' : 'No'}, On_Spotify: #{album.on_spotify ? 'Yes' : 'No'}"
    end
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end

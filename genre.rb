require_relative 'item'

class Genre < Item
  attr_accessor :name
  attr_reader :id, :items

  def initialize(id, publish_date, name)
    super(id, publish_date, false)
    @id = id || Random.rand(1..100)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  def self.add_genre(genre)
    puts genre
  end

  def self.list_all_genres
    MusicAlbum.load_albums
    puts 'No genres added.'
    puts @items
  end
end

require_relative 'item'

class Genre < Item
  attr_accessor :name
  attr_reader :id, :items

  def initialize(id, name)
    super(id, nil, false)
    @id = id || Random.rand(1..100)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end
end

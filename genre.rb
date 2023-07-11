class Genre
  attr_accessor :name
  attr_reader :id, :items

  def initialize(id, name)
    @id = id || Random.rand(1..100)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
  end
end

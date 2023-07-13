require_relative 'item'

class Label
  attr_reader :title, :color, :items, :id

  def initialize(id, title, color)
    @id = id || Random.rand(1..100)
    @title = title
    @color = color
    @items = []
  end
end

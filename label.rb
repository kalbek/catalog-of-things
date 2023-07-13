require_relative 'item'

class Label
  attr_reader :title, :color, :items, :id

  def initialize(id, title, color)
    @id = id || Random.rand(1..100)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    return if items.include?(item)

    @items << item
    item.label = self
    add_items_to_file(item)
  end

  def to_json(*_args)
    {
      'id' => id,
      'title' => title,
      'color' => color
    }.to_json
  end

  def add_items_to_file(items)
    loaded_items = load_items_data
    loaded_items << items
    item_data = loaded_items.map do |item|
      {
        'id' => item.id,
        'publish_date' => item.publish_date,
        'archived' => item.archived,
        'label' => if item.label.is_a?(Hash)
                     item.label
                   else
                     {
                       'id' => item.label.id,
                       'title' => item.label.title,
                       'color' => item.label.color
                     }
                   end
      }
    end
    puts item_data
    File.write('items.json', JSON.generate(item_data))
  end
end

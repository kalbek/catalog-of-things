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
    File.write('items.json', JSON.generate(item_data))
  end

  def self.list_all
    puts 'All Labels:'
    labels = JSON.parse(File.read('labels.json'), symbolize_names: true)
    labels.each do |label|
      puts "id: #{label[:id]} title: #{label[:title]}, label-color: #{label[:color]}"
    end
  end

  def convert_to_hash
    {
      'id' => id,
      'title' => title,
      'color' => color
    }
  end

  def save_labels_to_file(labels)
    label_data = labels.map do |label|
      {
        'id' => label.id,
        'title' => label.title,
        'color' => label.color
      }
    end
    File.write('labels.json', JSON.generate(label_data))
  end

  def self.load_labels
    return [] unless File.exist?('labels.json') && !File.empty?('labels.json')

    label_data = JSON.parse(File.read('labels.json'))
    label_data.map do |label|
      Label.new(label['id'], label['title'], label['color'])
    end
  end

  def load_items_data
    return [] unless File.exist?('items.json') && !File.empty?('items.json')

    item_data = JSON.parse(File.read('items.json'))
    item_data.map do |data|
      item = Item.new(data['id'], data['publish_date'], data['archived'])
      item.label = data['label']
      item
    end
  end
end

require_relative '../genre'
require 'date'

RSpec.describe Genre do
  let(:genre_id) { 1 }
  let(:genre_name) { 'Fantasy' }
  let(:publish_date) {Date.today - (5 * 10) }
  let(:genre) { Genre.new(genre_id, publish_date, genre_name) }

  describe '#add_item' do
    let(:item) { double('Item') }

    it 'adds the item to the items array' do
      expect(item).to receive(:genre=).with(genre)
      genre.add_item(item)
      expect(genre.items).to include(item)
    end
  end
end

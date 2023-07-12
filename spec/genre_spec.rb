require_relative '../genre'

RSpec.describe Genre do
  let(:genre_id) { 1 }
  let(:genre_name) { 'Fantasy' }
  let(:genre) { Genre.new(genre_id, genre_name) }

  describe '#add_item' do
    let(:item) { double('Item') }

    it 'adds the item to the items array' do
      expect(item).to receive(:genre=).with(genre)
      genre.add_item(item)
      expect(genre.items).to include(item)
    end
  end
end

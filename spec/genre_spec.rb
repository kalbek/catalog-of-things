require_relative '../genre'
require 'date'

RSpec.describe Genre do
  let(:genre_id) { 1 }
  let(:genre_name) { 'Fantasy' }
  let(:publish_date) { Date.today - (5 * 10) }
  let(:genre) { Genre.new(genre_id, publish_date, genre_name) }

  describe '#add_item' do
    let(:item) { double('Item') }

    it 'adds the item to the items array' do
      expect(item).to receive(:genre=).with(genre)
      genre.add_item(item)
      expect(genre.items).to include(item)
    end
  end

  describe '.add_genre' do
    let(:existing_genre) { Genre.new(genre_id, publish_date, genre_name) }
    let(:item) { double('Item') }
    let(:new_genre) { Genre.new(2, Date.today, 'Sci-Fi') }
    let(:new_item) { double('Item') }

    before do
      allow(existing_genre).to receive(:add_item).with(new_item)
      allow(Genre).to receive(:load_genres).and_return([existing_genre])
      allow(File).to receive(:exist?).with('genres.json').and_return(true)
      allow(File).to receive(:empty?).with('genres.json').and_return(false)
      allow(File).to receive(:read).with('genres.json').and_return('[]')
      allow(File).to receive(:write).with('genres.json', anything)
    end

    it 'creates a new genre and adds the item if a similar genre does not exist' do
      allow(Genre).to receive(:load_genres).and_return([])
      expect(Genre).to receive(:save_genres_to_file)
      Genre.add_genre(new_genre)
    end
  end

  describe '.load_genres' do
    let(:genre_data) { [{ 'id' => 1, 'date' => '2023-07-12', 'name' => 'Fantasy', 'items' => [] }] }

    before do
      allow(File).to receive(:exist?).with('genres.json').and_return(true)
      allow(File).to receive(:empty?).with('genres.json').and_return(false)
      allow(File).to receive(:read).with('genres.json').and_return(genre_data.to_json)
    end

    it 'loads and returns an array of Genre objects from the genres.json file' do
      genres = Genre.load_genres
      expect(genres).to be_an(Array)
      expect(genres.length).to eq(1)
      expect(genres.first).to be_a(Genre)
      expect(genres.first.id).to eq(1)
      expect(genres.first.publish_date).to eq('2023-07-12')
      expect(genres.first.name).to eq('Fantasy')
      expect(genres.first.items).to be_empty
    end
  end
end

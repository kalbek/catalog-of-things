require_relative '../author'

RSpec.describe Author do
  let(:author) { Author.new(1, 'John', 'Doe') }

  describe '#initialize' do
    it 'sets the id' do
      expect(author.id).to eq(1)
    end

    it 'sets the firstname' do
      expect(author.firstname).to eq('John')
    end

    it 'sets the lastname' do
      expect(author.lastname).to eq('Doe')
    end

    it 'initializes an empty items array' do
      expect(author.items).to be_an(Array)
      expect(author.items).to be_empty
    end
  end

  describe '#add_item' do
    let(:item) { double('item') }

    it 'adds an item to the items array' do
      expect(author.items).to be_empty
      author.add_item(item)
      expect(author.items).to contain_exactly(item)
    end
  end

  describe '#convert_to_hash' do
    it 'returns a hash representation of the author' do
      hash = author.convert_to_hash
      expect(hash).to be_a(Hash)
      expect(hash[:id]).to eq(1)
      expect(hash[:firstname]).to eq('John')
      expect(hash[:lastname]).to eq('Doe')
    end
  end

  describe '.load_authors_data' do
    it 'loads author data from the file' do
      expect(File).to receive(:exist?).with('authors.json').and_return(true)
      expect(File).to receive(:empty?).with('authors.json').and_return(false)
      expect(File).to receive(:read).with('authors.json').and_return('[]')

      authors = Author.load_authors_data

      expect(authors).to be_an(Array)
      expect(authors).to be_empty
    end
  end
end

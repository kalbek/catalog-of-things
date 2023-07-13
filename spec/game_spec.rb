require_relative '../game'

RSpec.describe Game do
 let(:game) { Game.new(1, true, '2023-07-01', Date.today) }

 describe '#add_item' do
   let(:item) { double('item') }
   let(:author) { double('author') }

   it 'sets the author on the item' do
     expect(item).to receive(:author=).with(author)
     game.add_item(item, author)
   end
 end
 
  describe '#add_item' do
    let(:item) { double('item') }
    let(:author) { double('author') }

    it 'sets the author on the item' do
      expect(item).to receive(:author=).with(author)
      game.add_item(item)
    end
  end

  describe '.load_games_data' do
    it 'loads game data from the file' do
      expect(File).to receive(:exist?).with('games.json').and_return(true)
      expect(File).to receive(:empty?).with('games.json').and_return(false)
      expect(File).to receive(:read).with('games.json').and_return('[]')

      games = Game.load_games_data

      expect(games).to be_an(Array)
      expect(games).to be_empty
    end
  end
end

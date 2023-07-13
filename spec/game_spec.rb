require_relative '../game'

RSpec.describe Game do
  let(:game) { Game.new(1, true, '2023-07-01', Date.today) }

  describe '#initialize' do
    it 'sets the id' do
      expect(game.id).to eq(1)
    end

    it 'sets the multiplayer attribute' do
      expect(game.multiplayer).to eq(true)
    end

    it 'sets the last_played_at attribute' do
      expect(game.last_played_at).to eq('2023-07-01')
    end

    it 'sets the publish_date attribute' do
      expect(game.publish_date).to eq(Date.today)
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

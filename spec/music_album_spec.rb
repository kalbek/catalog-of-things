require_relative '../music_album'
require 'date'

RSpec.describe MusicAlbum do
  let(:album_id) { 1 }
  let(:album_publish_date) { Date.today - (15 * 365) }
  let(:album_on_spotify) { true }
  let(:album) { MusicAlbum.new(album_id, album_publish_date, album_on_spotify) }

  describe '#initialize' do
    it 'sets the on_spotify attribute' do
      expect(album.on_spotify).to eq(album_on_spotify)
    end

    it 'sets the id attribute' do
      expect(album.id).to eq(album_id)
    end

    it 'sets the archived attribute to true if the item is on Spotify and can be archived' do
      album = MusicAlbum.new(album_id, album_publish_date, true)
      expect(album.archived).to be_truthy
    end

    it 'sets the publish_date attribute' do
      expect(album.publish_date).to eq(album_publish_date)
    end
  end

  describe '#move_to_archive' do
    it 'archives the item if it can be archived' do
      album.move_to_archive
      expect(album.archived).to be_truthy
    end

    it 'does not archive the item if it cannot be archived' do
      album = MusicAlbum.new(album_id, album_publish_date, false)
      expect(album.archived).to be_falsey
    end
  end
end

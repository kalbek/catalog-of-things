require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state, :publish_date
  attr_reader :id

  def initialize(id, publisher, cover_state, publish_date, label)
    super(id, publish_date, false)
    @id = id || Random.rand(1..100)
    @publisher = publisher
    @cover_state = cover_state
    @publish_date = publish_date
    @label = label
    update_archived_status
  end
end

class Item
  attr_accessor :label, :genre, :author, :publish_date
  attr_reader :id, :archived

  def initialize(id, publish_date, archived)
    @id = id || Random.rand(1..100)
    @publish_date = publish_date
    @archived = false || archived
    @label = nil
    @genre = nil
    @author = nil
  end
end
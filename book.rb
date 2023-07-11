require_relative 'item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state)
    super(id, publish_date, label, false)
    @id = id || Random.rand(1..100)
    @publisher = publisher
    @cover_state = cover_state
    @publish_date = publish_date
    @label = label
    update_archived_status
  end

  def can_be_archived?
    super && cover_state == 'bad'
  end

  def update_archived_status
    @archived = can_be_archived?
  end

  def self.add_a_book
    book_data = book_details
    puts 'getting book data ...'
    puts book_data
  end

  def self.validate_date
   date_input = gets.chomp

   begin
    Date.parse(date_input)
  rescue ArgumentError
    print 'Invalid date!'
    validate_date
  end
  end

  def self.book_details

    book_data = []
    book_data = {
        'publisher' => '',
        'cover_state' => '',
        'publish_date' => '',
        'label_title' => '',
    }
    print "Enter the book's publisher: "
    publisher = gets.chomp
    book_data << publisher

    print "Books' cover state: "
    cover_state = gets.chomp
    book_data << cover_state 
    
    print 'Publish date (YYYY-MM-DD): '
    date = validate_date
    book_data << date 
    
    print "Book label's title: "
    label_title = gets.chomp
    book_data << label_title 

    print "Book label's color: "
    label_color = gets.chomp
    book_data << label_color
  end
end

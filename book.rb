require_relative 'item'
require_relative 'label'
require 'date'
require 'json'

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

  def can_be_archived?
    super && cover_state == 'bad'
  end

  def update_archived_status
    @archived = can_be_archived?
  end

  def self.validate_date
    date_input = gets.chomp

    begin
      Date.parse(date_input)
    rescue ArgumentError
      print 'Invalid date! Enter valid date: '
      validate_date
    end
  end

  def self.book_details
    book_data = {
      publisher: '',
      cover_state: '',
      publish_date: Date.today,
      label_title: '',
      label_color: ''
    }
    
    print "Enter the book's publisher: "
    book_data[:publisher] = gets.chomp

    print "Books' cover state: "
    book_data[:cover_state] = gets.chomp

    print 'Publish date (YYYY-MM-DD): '
    book_data[:publish_date] = validate_date

    print "Book label's title: "
    book_data[:label_title] = gets.chomp

    print "Book label's color: "
    book_data[:label_color] = gets.chomp

    book_data
  end

  def self.add_a_book
    # load book and label data from json files
    book_data =  book_details
    loaded_books = load_books_data
    
    
    data = update_loaded_data(book_data)

    book = data[:book]
    label = data[:label]
    date = data[:publish_date]
    loaded_books = data[:loaded_books]
    loaded_labels = data[:loaded_labels]

    add_book_items_to_list(book_data, book, label, date)
    
    save_books_to_file(loaded_books)
    label.save_labels_to_file(loaded_labels)
  end
  
  def self.add_book_items_to_list(book_data, book, label, date)
    # add book to item list (add a book item in items)
    items = JSON.parse(File.read('items.json'), symbolize_names: true)
    item = Item.new(items.length + 1, book_data[:publish_date], book.can_be_archived?)
    item.label = label
    label.add_item(item)
    puts 'Book added successfully!'
  end

  # create the book from the prompted details
  def self.update_loaded_data(book_data)
    loaded_books = load_books_data
    loaded_labels = Label.load_labels_data

    label = Label.new(loaded_books.length + 1, book_data[:label_title], book_data[:label_color])
    book = Book.new(loaded_books.length + 1, book_data[:publisher], book_data[:cover_state], book_data[:publish_date], label)
    loaded_labels << label
    loaded_books << book
    data = {
      book: book,
      label: label,
      loaded_labels: loaded_labels,
      loaded_books: loaded_books
    }
    data

  end

  def self.save_books_to_file(books)
    book_data = books.map do |book|
      {
        'id' => book.id,
        'publisher' => book.publisher,
        'publish_date' => book.publish_date,
        'cover_state' => book.cover_state,
        'label' =>  book.label
      }
    end
    File.write('books.json', JSON.generate(book_data))
  end

  def self.load_books_data
    return [] unless File.exist?('books.json') && !File.empty?('books.json')

    book_data = JSON.parse(File.read('books.json'))
    book_data.map do |data|
      book = Book.new(data['id'], data['publisher'], data['cover_state'], Date.parse(data['publish_date']),
                      data['label'])
      book
    end
  end
end

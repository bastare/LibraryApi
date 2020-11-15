# typed: false
# frozen_string_literal: true

require_relative 'index'

library = Library.new

# seed
unless library.unit.author.fetch_all&.any?
  Helper::DataSeed.seed_data 10, library

  author1 = Models::Author.new(11, name: 'first', biography: '')
  author2 = Models::Author.new(12, name: 'second', biography: '')

  library.add_author author1
  library.add_author author2

  book1 = Models::Book.new(11, title: 'some title', author: author1)
  book2 = Models::Book.new(12, title: 'some title', author: author2)

  library.add_book book1
  library.add_book book2

  reader1 = Models::Reader.new(11, name: 'dfsd', house: 7, email: '', city: '', street: '')

  library.add_reader reader1

  library.add_order Models::Order.new(11,
                                      reader: library.unit.reader.fetch_entity(2),
                                      book: library.unit.book.fetch_entity(1))

  library.add_order Models::Order.new(12,
                                      reader: reader1,
                                      book: book2)

  library.add_order Models::Order.new(14,
                                      reader: library.unit.reader.fetch_entity(9),
                                      book: library.unit.book.fetch_entity(4))

  library.add_order Models::Order.new(16,
                                      reader: library.unit.reader.fetch_entity(9),
                                      book: library.unit.book.fetch_entity(3))

  library.add_order Models::Order.new(18,
                                      reader: library.unit.reader.fetch_entity(9),
                                      book: library.unit.book.fetch_entity(3))
  library.save
end

logger = Helper::Logger::LibraryLogger.new library

logger.print_top_readers 5

logger.print_top_books 5

logger.print_number_of_top_readers 2

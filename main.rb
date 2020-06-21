# typed: false
# frozen_string_literal: true

require_relative 'index'

library = Library.new

# seed
unless library.unit.author.fetch_all&.any?
  Helper::DataSeed.seed_data 10, library

  author1 = Models::Author.new(11, name: 'first', biography: '')
  author2 = Models::Author.new(12, name: 'second', biography: '')

  library.push author1, entitys: :authors
  library.push author2, entitys: :authors

  book1 = Models::Book.new(11, title: 'some title', author: author1)
  book2 = Models::Book.new(12, title: 'some title', author: author2)

  library.push book1, entitys: :books
  library.push book2, entitys: :books

  reader1 = Models::Reader.new(11, name: 'dfsd', house: 7, email: '', city: '', street: '')

  library.push reader1,entitys: :readers

  order1 = Models::Order.new(11,
                             reader: library.unit.reader.fetch_entity(2),
                             book: library.unit.book.fetch_entity(1))

  library.push order1, entitys: :orders

  order2 = Models::Order.new(12,
                             reader: reader1,
                             book: book2)

  library.push order2, entitys: :orders

  order3 = Models::Order.new(14,
                             reader: library.unit.reader.fetch_entity(9),
                             book: library.unit.book.fetch_entity(4))

  library.push order3, entitys: :orders

  order4 = Models::Order.new(16,
                             reader: library.unit.reader.fetch_entity(9),
                             book: library.unit.book.fetch_entity(3))

  library.push order4, entitys: :orders

  order5 = Models::Order.new(18,
                             reader: library.unit.reader.fetch_entity(9),
                             book: library.unit.book.fetch_entity(3))

  library.push order5,entitys: :orders

  library.save
end

logger = Helper::Logger::LibraryLogger.new library

logger.print_top_readers 5

logger.print_top_books 5

logger.print_number_of_top_readers 2

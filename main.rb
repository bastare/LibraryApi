# typed: false
# frozen_string_literal: true

require_relative 'index'

lib = Library.new

# seed
unless lib.unit.author.fetch_all&.any?
  Helper.seed_data 10, lib

  author1 = Models::Author.new(11, name: 'first', biography: '')
  author2 = Models::Author.new(12, name: 'second', biography: '')

  lib.authors << author1
  lib.authors << author2

  book1 = Models::Book.new(11, title: 'some title', author: author1)
  book2 = Models::Book.new(12, title: 'some title', author: author2)

  lib.books << book1
  lib.books << book2

  reader1 = Models::Reader.new(11, name: 'dfsd', house: 7, email: '', city: '', street: '')

  lib.readers << reader1

  lib.orders << Models::Order.new(11,
                                  reader: lib.unit.reader.fetch_entity(2),
                                  book: lib.unit.book.fetch_entity(1))

  lib.orders << Models::Order.new(12,
                                  reader: reader1,
                                  book: book2)

  lib.orders << Models::Order.new(14,
                                  reader: lib.unit.reader.fetch_entity(9),
                                  book: lib.unit.book.fetch_entity(4))

  lib.orders << Models::Order.new(18,
                                  reader: lib.unit.reader.fetch_entity(9),
                                  book: lib.unit.book.fetch_entity(3))
end

lib.save

# fetch data

# fetch_book = lib.unit.book.fetch_entity 3

# fetch_all_orders = lib.unit.order.fetch_all

# p fetch_book, fetch_all_orders

# task1

result1 = lib.reader_bll.top_readers 1000

Helper::Logger.out(result1, :reader, :unique_books_id, 'Top reader(-s)') if result1

# task2

result2 = lib.book_bll.top_books 100

Helper::Logger.out(result2, :book, :unique_readers_id, 'Top book(-s)') if result2

# task3

result3 = lib.book_bll.readers_interests 3

p "Number of unique readers dat order top books: #{result3}" if result3

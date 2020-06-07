# frozen_string_literal: true

require_relative './library.rb'
require_relative './seed'
require_relative './helpers/logger'

lib = Library.new

# seed

Helper.seed_data 10

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
                                reader: lib.unit.reader.fetch_entity(1),
                                book: lib.unit.book.fetch_entity(12))

lib.save

# fetch data

fetch_book = lib.unit.book.fetch_entity 3

fetch_all_orders = lib.unit.order.fetch_all

p fetch_book, fetch_all_orders

# task1

result1 = lib.reader_bll.top_readers 5

Helper::Logger.out(result1, :reader, :unique_books, 'Top reader(-s)') if result1

# task2

result2 = lib.book_bll.top_books 3

Helper::Logger.out(result2, :book, :unique_readers, 'Top book(-s)') if result2

# task3

result3 = lib.book_bll.readers_interests 1

p "Number of unique readers dat order top books: #{result3}" if result3

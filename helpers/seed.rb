# typed: false
# frozen_string_literal: true

require_relative '../index'

module Helper
  module DataSeed
    class << self
      def seed_data(number, library)
        seed_author library, number
        seed_book   library, number
        seed_reader library, number
        seed_order  library, number

        library.save
      end

      private

      def seed_author(library, number)
        number.times do |index|
          library.push Models::Author.new(index, name: "au_#{index}"), entitys: :authors
        end
      end

      def seed_book(library, number)
        number.times do |index|
          author = library.authors[Random.rand(number)]

          library.push Models::Book.new(index, title: "bo_#{index}", author: author), entitys: :books
        end
      end

      def seed_reader(library, number)
        number.times do |index|
          library.push Models::Reader.new(index, name: '', house: index, email: '', city: '', street: ''), entitys: :readers
        end
      end

      def seed_order(library, number)
        number.times do |index|
          reader = library.readers[Random.rand(number)]
          book   = library.books[Random.rand(number)]

          library.push Models::Order.new(index, reader: reader, book: book), entitys: :orders
        end
      end
    end
  end
end

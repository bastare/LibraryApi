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
          library.authors << Models::Author.new(index, name: "au_#{index}")
        end
      end

      def seed_book(library, number)
        number.times do |index|
          author =  library.authors[Random.rand(number)]

          library.books << Models::Book.new(index, title: "bo_#{index}", author: author)
        end
      end

      def seed_reader(library, number)
        number.times do |index|
          library.readers << Models::Reader.new(index, name: '', house: index, email: '', city: '', street: '')
        end
      end

      def seed_order(library, number)
        number.times do |index|
          reader = library.readers[Random.rand(number)]
          book   = library.books[Random.rand(number)]

          library.orders << Models::Order.new(index, reader: reader, book: book)
        end
      end
    end
  end
end

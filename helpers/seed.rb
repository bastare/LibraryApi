# typed: false
# frozen_string_literal: true

require_relative '../index'

# Module contain some extended logic for difference purpose
module Helper
  # Module contain logic for seeding data base
  module DataSeed
    class << self
      def seed_data(num, lib)
        seed_author lib, num
        seed_book   lib, num
        seed_reader lib, num
        seed_order  lib, num

        lib.save
      end

      private

      def seed_author(lib, num)
        num.times do |i|
          lib.authors << Models::Author.new(i, name: "au_#{i}")
        end
      end

      def seed_book(lib, num)
        num.times do |i|
          author =  lib.authors[Random.rand(num)]

          lib.books << Models::Book.new(i, title: "bo_#{i}", author: author)
        end
      end

      def seed_reader(lib, num)
        num.times do |i|
          lib.readers << Models::Reader.new(i, name: '', house: i, email: '', city: '', street: '')
        end
      end

      def seed_order(lib, num)
        num.times do |i|
          reader = lib.readers[Random.rand(num)]
          book   = lib.books[Random.rand(num)]

          lib.orders << Models::Order.new(i, reader: reader, book: book)
        end
      end
    end
  end
end

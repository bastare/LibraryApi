# frozen_string_literal: true

Dir['./models/*.rb'].sort.each { |file| require file }

# Module contain some extended logic for difference purpose
module Helper
  def self.init_seed(num)
    lib = Library.new

    seed_author lib, num
    seed_book   lib, num
    seed_order  lib, num
    seed_reader lib, num

    lib.save
  end

  class << self
    def seed_author(lib, num)
      num.times do |i|
        lib.authors << Models::Author.new(i, name: "au_#{i}")
      end
    end

    def seed_book(lib, num)
      num.times do |i|
        author =  Models::Author.new(i, name: 'first', biography: '')

        lib.books << Models::Book.new(i, book: "bo_#{i}", author: author)
      end
    end

    def seed_order(lib, num)
      num.times do |i|
        reader =  Models::Reader.new(i, name: '', house: 1, email: '', city: '', street: '')
        book = Models::Book.new(i, title: '')

        lib.orders << Models::Order.new(i, reader: reader, book: book)
      end
    end

    def seed_reader(lib, num)
      num.times do |i|
        lib.readers << Models::Reader.new(i, name: '', house: i, email: '', city: '', street: '')
      end
    end
  end
end

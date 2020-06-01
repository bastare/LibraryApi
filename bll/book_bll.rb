# frozen_string_literal: true

require_relative '../dal/unit_of_work'
# Module contain entites that implements BLL
module BLL
  # Class contain business logic for 'book'
  class BookBLL
    def initialize
      @unit = DAL::UnitOfWork.new
    end

    def top_books(limit = 1)
      return if limit <= 0

      statistic = init_books_stat&.to_a&.slice!(0...limit).to_h

      return unless statistic&.any?

      result = []

      statistic.each_pair do |key, value|
        result.push({ book: @unit.book.fetch_entity(key), unique_readers: value })
      end

      result
    end

    def readers_interests(quan = 3)
      return 0 if quan <= 0

      result = []

      statistic = init_reader_stat(quan)

      return 0 unless statistic&.any?

      statistic.each_value { |v| result.concat(v) }

      result.uniq!

      result.length
    end

    private

    def init_reader_stat(quan)
      orders = @unit.order.fetch_all

      return [] unless orders

      books = top_books(quan).collect do |i|
        i[:book]&.id
      end

      map_reader_stat(books, orders)
    end

    def map_reader_stat(books, orders)
      hash = {}
      books.collect do |id|
        hash[id] = [] if hash[id].nil?

        orders.each do |o|
          hash[id].push(o.reader.id) if o.book.id == id
        end
      end

      hash
    end

    def init_books_stat      
      hash = {}

      @unit.order.fetch_all.collect do |i|
        hash[i.book.id] = [] if hash[i.book.id].nil?

        hash[i.book.id].push i.reader.id
      end

      map_books_stat(hash)
    end

    def map_books_stat(hash)
      hash.each_value(&:uniq!)

      hash.each { |key, value| hash[key] = value.length }

      hash.sort_by { |_, v| -v }.to_h
    end
  end
end

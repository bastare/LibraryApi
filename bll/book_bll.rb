# typed: false
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
      raise ArgumentError, 'Limit should be poss num' unless limit&.positive?

      result = []

      statistic = init_books_stat&.slice(0...limit).to_h

      return result unless statistic&.any?

      statistic.each_pair do |k, v|
        result << { book: @unit.book.fetch_entity(k), unique_readers: v }
      end

      result
    end

    def readers_interests(quan = 3)
      raise ArgumentError, 'Quantity should be poss num' unless quan&.positive?

      result = []

      statistic = init_reader_stat(quan)

      return 0 unless statistic&.any?

      statistic.each_value { |v| result.concat(v) }

      result.uniq.length
    end

    private

    def init_reader_stat(quan)
      orders = @unit.order.fetch_all                        || return

      books = top_books(quan)&.collect { |i| i[:book]&.id } || return

      map_reader_stat(books, orders)
    end

    def map_reader_stat(books, orders)
      hash = Hash.new { |k, v| k[v] = [] }

      books.collect do |id|
        orders.each do |o|
          book_id   = o.book.id
          reader_id = o.reader.id

          hash[id] << reader_id if book_id == id
        end
      end

      hash
    end

    def init_books_stat
      orders = @unit.order.fetch_all || return

      hash = Hash.new { |k, v| k[v] = [] }

      orders.collect do |i|
        book_id   = i.book.id
        reader_id = i.reader.id

        hash[book_id] << reader_id
      end

      map_books_stat(hash)
    end

    def map_books_stat(hash)
      hash.each_value(&:uniq!)

      hash.each { |k, v| hash[k] = v&.length || 0 }

      hash.sort_by { |_, v| -v }
    end
  end
end

# typed: false
# frozen_string_literal: true

require_relative '../index'

# Module contain entites that implements BLL
module BLL
  # Class contain business logic for 'book'
  class BookBLL
    def initialize
      @unit = DAL::UnitOfWork.new
    end

    def top_books(limit = 1)
      raise ValidationError, 'Limit cannot be negative' unless limit&.positive?

      result = []

      statistic = init_books_stat(limit)

      return result unless statistic&.any?

      statistic.each_pair do |k, v|
        result << { book: @unit.book.fetch_entity(k), unique_readers: v }
      end

      result
    end

    def readers_interests(quan = 3)
      raise ValidationError, 'Quantity cannot be negative' unless quan&.positive?

      top_books(quan)&.map { |books_stat| books_stat[:unique_readers] }&.flatten&.uniq&.length || 0
    end

    private

    def init_books_stat(limit)
      orders = @unit.order.fetch_all || return

      hash = orders.each_with_object(Hash.new { |k, v| k[v] = [] }) do |order, hash_result|
        book_id   = order.book.id
        reader_id = order.reader.id

        hash_result[book_id] << reader_id
      end

      map_books_stat!(hash, limit)
    end

    def map_books_stat!(hash, limit)
      hash.each_value(&:uniq!).max_by(limit) { |_, v| v&.length || 0 }.to_h
    end
  end
end

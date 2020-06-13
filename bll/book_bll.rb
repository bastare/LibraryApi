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

      orders = @unit.order.fetch_all || return

      init_books_statistic(limit, orders).each_pair do |book_id, unique_readers_id|
        result << {
          book: orders.find { |order| order.book if order.book.id == book_id },
          unique_readers_id: unique_readers_id
        }
      end

      result
    end

    def readers_interests(quan = 3)
      raise ValidationError, 'Quantity cannot be negative' unless quan&.positive?

      top_books(quan)&.map { |books_statistic| books_statistic[:unique_readers_id] }&.flatten&.uniq&.length || 0
    end

    private

    def init_books_statistic(limit, orders)
      hash = orders.each_with_object(Hash.new { |k, v| k[v] = [] }) do |order, hash_result|
        book_id   = order.book.id
        reader_id = order.reader.id

        hash_result[book_id] << reader_id
      end

      hash.each_value(&:uniq!).max_by(limit) { |_, unique_readers_id| unique_readers_id&.length || 0 }.to_h
    end
  end
end

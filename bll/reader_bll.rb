# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain entites that implements BLL
module BLL
  # Class contain business logic for 'reader'
  class ReaderBLL
    def initialize
      @unit = DAL::UnitOfWork.new
    end

    def top_readers(limit = 1)
      raise Error::ValidationError, 'Limit cannot be negative' unless limit&.positive?

      result = []

      orders = @unit.order.fetch_all || return

      init_readers_statistic(limit, orders).each_pair do |reader_id, unique_readers_id|
        result << {
          reader: orders.find { |order| order.reader if order.reader.id == reader_id },
          unique_books_id: unique_readers_id
        }
      end

      result
    end

    private

    def init_readers_statistic(limit, orders)
      hash = orders.each_with_object(Hash.new { |k, v| k[v] = [] }) do |order, hash_result|
        book_id   = order.book.id
        reader_id = order.reader.id

        hash_result[reader_id] << book_id
      end

      hash.each_value(&:uniq!).max_by(limit) { |_, unique_books_id| unique_books_id&.length || 0 }.to_h
    end
  end
end

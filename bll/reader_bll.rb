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
      raise ValidationError, 'Limit should be poss num' unless limit&.positive?

      result = []

      statistic = init_readers_stat(limit)

      return result unless statistic&.any?

      statistic.each_pair do |k, v|
        result << { reader: @unit.reader.fetch_entity(k), unique_books: v }
      end

      result
    end

    private

    def init_readers_stat(limit)
      orders = @unit.order.fetch_all || return

      hash = Hash.new { |k, v| k[v] = [] }

      orders.each do |order|
        book_id   = order.book.id
        reader_id = order.reader.id

        hash[reader_id] << book_id
      end

      map_result!(hash, limit)
    end

    def map_result!(hash, limit)
      hash.each_value(&:uniq!).max_by(limit) { |_, v| v&.length || 0 }.to_h
    end
  end
end

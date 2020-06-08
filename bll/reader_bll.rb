# typed: true
# frozen_string_literal: true

require_relative '../dal/unit_of_work'
# Module contain entites that implements BLL
module BLL
  # Class contain business logic for 'reader'
  class ReaderBLL
    def initialize
      @unit = DAL::UnitOfWork.new
    end

    def top_readers(limit = 1)
      raise ArgumentError, 'Limit should be poss num' unless limit&.positive?

      result = []

      statistic = init_readers_stat&.slice(0...limit).to_h

      return result unless statistic&.any?

      statistic.each_pair do |k, v|
        result << { reader: @unit.reader.fetch_entity(k), unique_books: v }
      end

      result
    end

    private

    def init_readers_stat
      orders = @unit.order.fetch_all || return

      hash = Hash.new { |k, v| k[v] = [] }

      orders.collect do |i|
        book_id   = i.book.id
        reader_id = i.reader.id

        hash[reader_id] << book_id
      end

      map_result(hash)
    end

    def map_result(hash)
      hash.each_value(&:uniq!)

      hash.each { |k, v| hash[k] = v&.length || 0 }

      hash.sort_by { |_, v| -v }
    end
  end
end

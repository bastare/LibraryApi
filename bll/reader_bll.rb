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

      return result unless statistic&.empty?

      statistic.each_pair do |key, value|
        result << { reader: @unit.reader.fetch_entity(key), unique_books: value }
      end

      result
    end

    private

    def init_readers_stat
      orders = @unit.order.fetch_all || return

      hash = {}

      orders.collect do |i|
        book_id   = i.book.id
        reader_id = i.reader.id

        hash[reader_id] = [] if hash[reader_id].nil?

        hash[reader_id] << book_id
      end

      map_result(hash)
    end

    def map_result(hash)
      hash.each_value(&:uniq!)

      hash.each { |key, value| hash[key] = value&.length }

      hash.sort_by { |_, v| -v }
    end
  end
end

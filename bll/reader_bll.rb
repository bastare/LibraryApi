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
      return if limit <= 0

      statistic = init_readers_stat&.slice!(0...limit).to_h

      return unless statistic&.any?

      result = []

      statistic.each_pair do |key, value|
        result << { reader: @unit.reader.fetch_entity(key), unique_books: value }
      end

      result
    end

    private

    def init_readers_stat
      orders = @unit.order.fetch_all || []

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

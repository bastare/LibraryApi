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
      return  if limit <= 0

      statistic = init_readers_stat&.to_a&.slice!(0...limit).to_h

      return unless statistic&.any?

      result = []

      statistic.each_pair do |key, value|
        result.push({ reader: @unit.reader.fetch_entity(key), unique_books: value })
      end

      result
    end

    private

    def init_readers_stat
      orders = @unit.order.fetch_all

      return [] unless orders

      hash = {}
      
      orders.collect do |i|
        hash[i.reader.id] = [] if hash[i.reader.id].nil?

        hash[i.reader.id].push i.book.id
      end

      map_result(hash)
    end

    def map_result(hash)
      hash.each_value(&:uniq!)

      hash.each { |key, value| hash[key] = value.length }

      hash.sort_by { |_, v| -v }.to_h
    end
  end
end

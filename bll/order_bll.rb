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

      orders = @unit.order.fetch_all || return

      target = { subject: :reader, object: :book }

      initialize_statistic(limit, orders, **target).each_with_object([]) do |(reader_id, unique_books), result|
        result << {
          reader: orders.find { |order| order.reader.id == reader_id }.reader,
          unique_books: unique_books
        }
      end
    end

    def top_books(limit = 1)
      raise Error::ValidationError, 'Limit cannot be negative' unless limit&.positive?

      orders = @unit.order.fetch_all || return

      target = { subject: :book, object: :reader }

      initialize_statistic(limit, orders, **target).each_with_object([]) do |(book_id, unique_readers), result|
        result << {
          book: orders.find { |order| order.book.id == book_id }.book,
          unique_readers: unique_readers
        }
      end
    end

    def readers_interests(quan = 3)
      raise Error::ValidationError, 'Quantity cannot be negative' unless quan&.positive?

      top_books(quan)&.map { |books_statistic| books_statistic[:unique_readers] }&.flatten&.uniq(&:id)&.length || 0
    end

    private

    def initialize_statistic(limit, orders, **target)
      hash = orders.each_with_object(Hash.new { |k, v| k[v] = [] }) do |order, hash_result|
        subject_id = order.send(target[:subject])&.id || next
        object = order.send(target[:object])          || next

        hash_result[subject_id] << object
      end

      hash.each_value { |objects| objects.uniq!(&:id) }.max_by(limit) { |_, objects| objects&.count || 0 }.to_h
    end
  end
end

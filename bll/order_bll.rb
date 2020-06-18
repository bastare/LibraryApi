# typed: true
# frozen_string_literal: true

require_relative '../index'

module BLL
  class OrderBLL
    def initialize
      @unit = DAL::UnitOfWork.new
    end

    def top_readers(limit = 1)
      raise Error::ValidationError, 'Limit cannot be negative' unless limit&.positive?

      orders = @unit.order.fetch_all || raise(Error::ArgumentNilError, 'Database is empty')

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

      orders = @unit.order.fetch_all || raise(Error::ArgumentNilError, 'Database is empty')

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

      top_books(quan).map { |books_statistic| books_statistic[:unique_readers] }.flatten.uniq(&:id).count
    end

    private

    def initialize_statistic(limit, orders, **target)
      statistic = orders.each_with_object(Hash.new { |k, v| k[v] = [] }) do |order, hash_result|
        subject_id = order.send(target[:subject]).id
        object     = order.send(target[:object])

        hash_result[subject_id] << object
      end

      statistic.each_value { |objects| objects.uniq!(&:id) }.max_by(limit) { |_, objects| objects.count }.to_h
    end
  end
end

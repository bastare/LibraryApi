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

      target = { target: :reader, subject: :book }

      initialize_statistic(limit, orders, **target).each_with_object([]) do |(reader_id, unique_books_id), result|
        result << {
          reader: orders.find { |order| order.reader if order.reader.id == reader_id },
          unique_books: fetch_subjects(orders, unique_books_id, **target)
        }
      end
    end

    def top_books(limit = 1)
      raise Error::ValidationError, 'Limit cannot be negative' unless limit&.positive?

      orders = @unit.order.fetch_all || return

      target = { target: :book, subject: :reader }

      initialize_statistic(limit, orders, **target).each_with_object([]) do |(book_id, unique_readers_id), result|
        result << {
          book: orders.find { |order| order.book if order.book.id == book_id },
          unique_readers: fetch_subjects(orders, unique_readers_id, **target)
        }
      end
    end

    def readers_interests(quan = 3)
      raise Error::ValidationError, 'Quantity cannot be negative' unless quan&.positive?

      top_books(quan)&.map { |books_statistic| books_statistic[:unique_readers] }&.flatten&.uniq&.length || 0
    end

    private

    def fetch_subjects(orders, subjects_id, **target)
      subjects_id.map do |subject_id|
        orders.find { |order| order.send(target[:subject]) if order.send(target[:subject]).id == subject_id }
      end
    end

    def initialize_statistic(limit, orders, **target)
      hash = orders.each_with_object(Hash.new { |k, v| k[v] = Set.new }) do |order, hash_result|
        target_id  = order.send(target[:target]).id
        subject_id = order.send(target[:subject]).id

        hash_result[target_id] << subject_id
      end

      hash.max_by(limit) { |_, unique_books_id| unique_books_id&.length || 0 }.to_h
    end
  end
end

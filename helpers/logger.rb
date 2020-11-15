# typed: true
# frozen_string_literal: true

module Helper
  module Logger
    class LibraryLogger
      def initialize(library)
        @library = library || raise(ArgumentError, 'Value is nil')
      end

      def print_top_books(limit)
        p 'Top book(-s)'

        result = @library.order_bll.top_books(limit)

        result.each do |transfer|
          p "#{transfer[:book].id} -> #{transfer[:unique_readers].map(&:id)}"
        end
      end

      def print_top_readers(limit)
        p 'Top reader(-s)'

        result = @library.order_bll.top_readers(limit)

        result.each do |transfer|
          p "#{transfer[:reader].id} -> #{transfer[:unique_books].map(&:id)}"
        end
      end

      def print_number_of_top_readers(quantity)
        result = @library.order_bll.readers_interests(quantity)

        p "Number of unique readers dat order top books: #{result}"
      end
    end
  end
end

# typed: true
# frozen_string_literal: true

require_relative './author_repository'
require_relative './book_repository'
require_relative './order_repository'
require_relative './reader_repository'

# Module contain classes that represent Data Accsess Layer
module DAL
  # Unit of DAL entites
  class UnitOfWork
    attr_reader :author, :book, :order, :reader

    def initialize
      @author = AuthorDAL.new
      @book   = BookDAL.new
      @order  = OrderDAL.new
      @reader = ReaderDAL.new
    end
  end
end

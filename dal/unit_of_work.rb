# typed: true
# frozen_string_literal: true

Dir['./dal/*.rb'].sort.each { |file| require file }

# Module contain classes that represent Data Accsess Layer
module DAL
  # Unit of DAL entites
  class UnitOfWork
    attr_reader :author, :book, :order, :reader, :test

    def initialize
      @author = AuthorDAL.new
      @book   = BookDAL.new
      @order  = OrderDAL.new
      @reader = ReaderDAL.new
    end
  end
end

# typed: true
# frozen_string_literal: true

require_relative 'index'

class Library
  WrongTypeError = Class.new(ArgumentError)

  attr_reader   :unit,  :order_bll
  attr_accessor :books, :orders, :readers, :authors

  def initialize
    @unit = DAL::UnitOfWork.new

    @order_bll = BLL::OrderBLL.new

    @books      = []
    @orders     = []
    @readers    = []
    @authors    = []

    load!
  end

  def save
    @unit.save @authors, @books, @orders, @readers
  end

  def add_book(book)
    type_validation book, type: Models::Book

    books << book
  end

  def add_order(order)
    type_validation order, type: Models::Order

    orders << order
  end

  def add_reader(reader)
    type_validation reader, type: Models::Reader

    readers << reader
  end

  def add_author(author)
    type_validation author, type: Models::Author

    authors << author
  end

  private

  def load!
    @books   = @unit.book.fetch_all   || []
    @orders  = @unit.order.fetch_all  || []
    @readers = @unit.reader.fetch_all || []
    @authors = @unit.author.fetch_all || []
  end

  def type_validation(entity, type:)
    raise(WrongTypeError, 'Wrong type') unless entity.instance_of? type
  end
end

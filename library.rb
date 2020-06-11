# typed: true
# frozen_string_literal: true

require_relative 'index'

# Core entity dat contain all models & there behavior
class Library
  attr_reader   :unit, :reader_bll, :book_bll
  attr_accessor :books, :orders, :readers, :authors

  def initialize
    @unit = DAL::UnitOfWork.new

    @reader_bll = BLL::ReaderBLL.new
    @book_bll   = BLL::BookBLL.new

    load!
  end

  def save
    @unit.save @authors, @books, @orders, @readers
  end

  private

  def load!
    @books   = unit.book.fetch_all   || []
    @orders  = unit.order.fetch_all  || []
    @readers = unit.reader.fetch_all || []
    @authors = unit.author.fetch_all || []
  end
end

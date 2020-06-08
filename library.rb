# typed: true
# frozen_string_literal: true

Dir['./bll/*.rb'].sort.each { |file| require file }
Dir['./models/*.rb'].sort.each { |file| require file }

# Class
class Library
  attr_reader   :unit, :reader_bll, :book_bll
  attr_accessor :books, :orders, :readers, :authors

  def initialize
    @unit = DAL::UnitOfWork.new

    @reader_bll = BLL::ReaderBLL.new
    @book_bll   = BLL::BookBLL.new

    @books      = []
    @orders     = []
    @readers    = []
    @authors    = []
  end

  def save
    @unit.author.create  @authors unless @authors.empty?
    @unit.book.create    @books   unless @books.empty?
    @unit.order.create   @orders  unless @orders.empty?
    @unit.reader.create  @readers unless @readers.empty?

    reset!
  end

  private

  def reset!
    @books.clear
    @orders.clear
    @readers.clear
    @authors.clear
  end
end

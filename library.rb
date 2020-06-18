# typed: true
# frozen_string_literal: true

require_relative 'index'

# Core entity dat contain all models & there behavior
class Library
  attr_reader   :unit, :order_bll
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

  private

  def load!
    @books   = @unit.book.fetch_all   || []
    @orders  = @unit.order.fetch_all  || []
    @readers = @unit.reader.fetch_all || []
    @authors = @unit.author.fetch_all || []
  end
end

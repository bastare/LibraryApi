# typed: true
# frozen_string_literal: true

require_relative 'index'

class Library
  UndefineCollectionError = Class.new(ArgumentError)

  using Helper::StrickArray

  attr_reader :unit, :order_bll
  attr_reader :books, :authors, :orders, :readers

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

  def push(*args, entitys:)
    send(entitys)&.push args || raise(UndefineCollectionError, 'Undefine entitys collection')
  end

  private

  def load!
    @books   = @unit.book.fetch_all   || []
    @orders  = @unit.order.fetch_all  || []
    @readers = @unit.reader.fetch_all || []
    @authors = @unit.author.fetch_all || []
  end
end

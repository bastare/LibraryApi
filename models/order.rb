# frozen_string_literal: true

require 'yaml'

require_relative './interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'order' model
  class Order < Entity
    attr_reader :date, :reader, :book

    def initialize(id, order)
      super id

      @date = order[:date] || Time.new

      @reader = order[:reader]
      @book = order[:book]
    end
  end
end

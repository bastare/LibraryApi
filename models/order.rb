# typed: true
# frozen_string_literal: true

require 'date'

require_relative 'interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'order' model
  class Order < Entity
    attr_reader :date, :reader, :book

    def initialize(id, order)
      super id

      @date = order[:date]     || Time.now.to_date

      @reader = order[:reader] || raise_required
      @book = order[:book]     || raise_required
    end
  end
end

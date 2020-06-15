# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that mapping with db entites
module Models
  # Class represent 'order' model
  class Order < Entity
    attr_reader :date, :reader, :book

    def initialize(id, **order)
      super id

      validations order

      @date = order[:date] || Time.now.to_date

      @reader = order[:reader]
      @book   = order[:book]
    end

    private

    def validations(order)
      validation(order[:reader], required: true)
      validation(order[:book],   required: true)
    end
  end
end

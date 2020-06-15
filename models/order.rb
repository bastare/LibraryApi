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

      @date = order[:date]     || Time.now.to_date

      @reader = order[:reader] || raise(Error::FieldRequiredError, 'Field is required')
      @book = order[:book]     || raise(Error::FieldRequiredError, 'Field is required')
    end
  end
end

# typed: true
# frozen_string_literal: true

require_relative '../index'

module Models
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
      validation(order[:reader], presence: true)
      validation(order[:book],   presence: true)
    end
  end
end

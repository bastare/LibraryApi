# typed: true
# frozen_string_literal: true

require_relative 'interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'book' model
  class Book < Entity
    attr_reader :author, :title, :order

    def initialize(id, book)
      super id

      @title = book[:title]   || raise(FieldRequiredError, 'Field is required')

      @author = book[:author] || raise(FieldRequiredError, 'Field is required')
    end
  end
end

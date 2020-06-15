# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that mapping with db entites
module Models
  # Class represent 'book' model
  class Book < Entity
    attr_reader :author, :title, :order

    def initialize(id, **book)
      super id

      validations book

      @title = book[:title]

      @author = book[:author]
    end

    private

    def validations(book)
      validation(book[:title],  required: true)
      validation(book[:author], required: true)
    end
  end
end

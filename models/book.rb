# frozen_string_literal: true

require 'yaml'

require_relative './interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'book' model
  class Book < Entity
    attr_reader :author, :title, :order

    def initialize(id,book)
      super id

      @title = book[:title]

      @author = book[:author]
    end
  end
end

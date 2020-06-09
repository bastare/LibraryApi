# typed: true
# frozen_string_literal: true

require_relative 'interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'author' model
  class Author < Entity
    attr_reader :name, :biography

    def initialize(id, author)
      super id

      @name      = author[:name]      || raise(ArgumentError, 'Value is required')
      @biography = author[:biography] || '-'
    end
  end
end

# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that mapping with db entites
module Models
  # Class represent 'author' model
  class Author < Entity
    attr_reader :name, :biography

    def initialize(id, author)
      super id

      @name      = author[:name]      || raise(FieldRequiredError, 'Field is required')
      @biography = author[:biography] || '-'
    end
  end
end

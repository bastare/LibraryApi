# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that mapping with db entites
module Models
  # Class represent 'author' model
  class Author < Entity
    attr_reader :name, :biography

    def initialize(id, **author)
      super id

      validations author

      @name      = author[:name]
      @biography = author[:biography] || '-'
    end

    private

    def validations(author)
      validation(author[:name], required: true)
    end
  end
end

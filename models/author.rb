# typed: true
# frozen_string_literal: true

require_relative '../index'

module Models
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
      validation(author[:name], presence: true)
    end
  end
end

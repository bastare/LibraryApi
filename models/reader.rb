# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that mapping with db entites
module Models
  # Class represent 'reader' model
  class Reader < Entity
    attr_reader :name, :email, :city, :street, :house

    def initialize(id, **reader)
      super id

      validations reader

      @house = reader[:house]

      @name   = reader[:name]   || raise(Error::FieldRequiredError, 'Field is required')
      @email  = reader[:email]  || raise(Error::FieldRequiredError, 'Field is required')
      @city   = reader[:city]   || raise(Error::FieldRequiredError, 'Field is required')
      @street = reader[:street] || raise(Error::FieldRequiredError, 'Field is required')
    end

    private

    def validations(reader)
      validation(reader[:house], ->(house) { house&.positive? || house&.zero? }, required: true) do
        raise Error::ValidationError, 'Value is nil or negative number'
      end
    end
  end
end

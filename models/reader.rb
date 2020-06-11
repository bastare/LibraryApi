# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that mapping with db entites
module Models
  # Class represent 'reader' model
  class Reader < Entity
    attr_reader :name, :email, :city, :street, :house

    def initialize(id, reader)
      super id

      @house = Validation.validate_house reader[:house]

      @name   = reader[:name]   || raise(FieldRequiredError, 'Field is required')
      @email  = reader[:email]  || raise(FieldRequiredError, 'Field is required')
      @city   = reader[:city]   || raise(FieldRequiredError, 'Field is required')
      @street = reader[:street] || raise(FieldRequiredError, 'Field is required')
    end
  end
end

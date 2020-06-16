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

      @house  = reader[:house]
      @name   = reader[:name]
      @email  = reader[:email]
      @city   = reader[:city]
      @street = reader[:street]
    end

    private

    def validations(reader)
      validation(reader[:house], ->(house) { house&.positive? || house&.zero? }, required: true) do
        raise Error::ValidationError, '`House` veriable is nil or negative number'
      end

      validation(reader[:name],   required: true)
      validation(reader[:email],  required: true)
      validation(reader[:city],   required: true)
      validation(reader[:street], required: true)
    end
  end
end

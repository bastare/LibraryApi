# typed: true
# frozen_string_literal: true

require_relative '../index'

module Models
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
      validation(reader[:house], ->(house) { house&.positive? || house&.zero? }, presence: true) do
        raise Error::ValidationError, '`House` veriable is nil or negative number'
      end

      validation(reader[:name],   presence: true)
      validation(reader[:email],  presence: true)
      validation(reader[:city],   presence: true)
      validation(reader[:street], presence: true)
    end
  end
end

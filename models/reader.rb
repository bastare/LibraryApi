# typed: true
# frozen_string_literal: true

require_relative 'interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'reader' model
  class Reader < Entity
    attr_reader :name, :email, :city, :street, :house

    def initialize(id, reader)
      super id

      validate_house reader[:house]

      @house = reader[:house]
      @name = reader[:name] || raise_required
      @email = reader[:email] || raise_required
      @city = reader[:city]   || raise_required
      @street = reader[:street] || raise_required
    end

    private

    def validate_house(house)
      raise ArgumentError, 'Value is nil or negative number' unless house&.positive? || house&.zero?
    end
  end
end

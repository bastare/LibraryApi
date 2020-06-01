# frozen_string_literal: true

require 'yaml'

require_relative './interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'reader' model
  class Reader < Entity
    attr_reader :name, :email, :city, :street, :house

    def initialize(id, reader)
      super id

      validate_house reader[:house]

      @name   = reader[:name]
      @house  = reader[:house]
      @email  = reader[:email]
      @city   = reader[:city]
      @street = reader[:street]
    end

    private

    def validate_house(house)
      raise ArgumentError, 'Value is nil or negative number' unless house&.positive? || house&.zero?
    end
  end
end

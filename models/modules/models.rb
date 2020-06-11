# frozen_string_literal: true

# Module contain classes that mapping with db entites
module Models
  def self.fetch_class(class_name)
    constants.map(&method(:const_get)).grep(Class)&.find do |i|
      i.name.match(/(?<=::)#{Regexp.quote(class_name)}$/)
    end
  end

  # Module contain validation behavior
  module Validation
    def self.validate_house(house)
      raise ValidationError, 'Value is nil or negative number' unless house&.positive? || house&.zero?

      house
    end
  end

  class FieldRequiredError < ArgumentError
  end

  class ValidationError < ArgumentError
  end
end

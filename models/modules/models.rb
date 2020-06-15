# frozen_string_literal: true

# Module contain classes that mapping with db entites
module Models
  def self.fetch_class(class_name)
    constants.map(&method(:const_get)).grep(Class)&.find do |i|
      i.name.match(/(?<=::)#{Regexp.quote(class_name)}$/)
    end
  end

  # Module contain validation behavior
  module Validatable
    protected

    def validation(target, predicate = nil, required: false)
      required_validation(target, required)

      validation_result = predicate&.call(target) || return

      unless validation_result
        block_given? ? yield : raise(Error::ValidationError, 'Validation failed')
      end
    end

    private

    def required_validation(target, required)
      raise(Error::FieldRequiredError, 'Field is required') if required && target.nil?
    end
  end

  # Module contain custom error classes
  module Error
    class WrongTypeError < ArgumentError
    end

    class ArgumentNilError < ArgumentError
    end

    class FieldRequiredError < ArgumentError
    end

    class ValidationError < ArgumentError
    end
  end
end

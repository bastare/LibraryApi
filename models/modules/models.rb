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

    def validation(target, predicate = nil, required: false, &block)
      required_validation(target)                     if required
      condition_validation(target, predicate, &block) unless predicate.nil?
    end

    private

    def condition_validation(target, predicate)
      unless predicate.call(target)
        block_given? ? yield : raise(Error::ValidationError, 'Validation failed')
      end
    end

    def required_validation(target)
      raise(Error::FieldRequiredError, 'Field is required') if target.nil?
    end
  end

  # Module contain custom error classes
  module Error
    class ArgumentNilError < ArgumentError
    end

    class FieldRequiredError < ArgumentError
    end

    class ValidationError < ArgumentError
    end
  end
end

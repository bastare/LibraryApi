# frozen_string_literal: true

# Module contain classes that mapping with db entites
module Models
  # Module contain validation behavior
  module Validatable
    protected

    def validation(target, predicate = nil, required: false, &block)
      required_validation(target)                     if required
      condition_validation(target, predicate, &block) unless predicate.nil?
    end

    private

    def condition_validation(target, predicate)
      return if predicate.call(target)

      block_given? ? yield(target) : raise(Error::ValidationError, 'Validation failed')
    end

    def required_validation(target)
      raise(Error::FieldRequiredError, 'Field is required') if target.nil?
    end
  end
end

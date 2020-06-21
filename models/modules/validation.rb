# frozen_string_literal: true

module Models
  module Validatable
    protected

    def validation(target, predicate = nil, presence: false, &block)
      required_validation(target)                     if presence
      condition_validation(target, predicate, &block) if predicate
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

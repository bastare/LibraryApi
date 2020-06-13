# typed: true
# frozen_string_literal: true

require_relative 'value_object'

# Module contain classes that mapping with db entites
module Models
  # Class represent abstraction for models
  class Entity
    prepend ValueObject

    attr_reader :id

    def initialize(id)
      @id = id || raise(FieldRequiredError, 'Field is required')
    end
  end
end

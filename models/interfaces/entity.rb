# typed: true
# frozen_string_literal: true

require 'yaml'

require_relative 'value_object'

# Module contain classes that mapping with db entites
module Models
  # Class represent abstraction for models
  class Entity
    prepend ValueObject

    attr_reader :id

    def initialize(id)
      @id = id || raise_required
    end

    def to_h
      hash = {}
      instance_variables.each { |attribute| hash[attribute] = instance_variable_get(attribute) }

      hash
    end
  end
end

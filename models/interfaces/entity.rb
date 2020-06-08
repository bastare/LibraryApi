# typed: true
# frozen_string_literal: true

require 'yaml'
# Module contain classes that mapping with db entites
module Models
  # Class represent abstraction for models
  class Entity
    attr_reader :id

    def initialize(id)
      @id = id || raise_required
    end

    def to_h
      hash = {}
      instance_variables.each { |attribute| hash[attribute] = instance_variable_get(attribute) }

      hash
    end

    protected

    def raise_required
      raise ArgumentError, 'Value is required'
    end
  end
end

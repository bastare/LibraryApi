# frozen_string_literal: true

# Module contain classes that mapping with db entites
module Models
  # Class represent abstraction for models
  class Entity
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def to_h
      hash = {}
      instance_variables.each { |attribute| hash[attribute] = instance_variable_get(attribute) }

      hash
    end
  end
end

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

    protected

    def has_many(*entitys)
      return unless entitys&.any?

      entitys.each do |key|
        instance_variable_set "@#{key}s", []
        self.class.send(:attr_accessor, key)
      end
    end

    def has_one(*entitys)
      return unless entitys&.any?

      entitys.each do |e|
        e.each do |key, value|
          instance_variable_set "@#{key}", value
          self.class.send(:attr_accessor, key)
        end
      end
    end
  end
end

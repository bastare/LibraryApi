# typed: true
# frozen_string_literal: true

require_relative 'value_object'

module Models
  class Entity
    prepend ValueObject
    include Validatable

    extend  AbstractClass

    attr_reader :id

    def initialize(id)
      validation(id, presence: true)

      @id = id
    end
  end
end

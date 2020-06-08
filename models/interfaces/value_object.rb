# frozen_string_literal: true

# Module contain classes that mapping with db entites
module Models
  # Module represent partition implementation of ValueObject pattern
  module ValueObject
    alias instance instance_variable_get

    def equal?(other)
      return false unless instance_of? other&.class

      instance_variables.each do |attr|
        return false unless instance(attr)&.equal? other&.instance(attr)
      end

      true
    end

    def ==(other)
      equal? other
    end
  end
end

# frozen_string_literal: true

# Module contain classes that mapping with db entites
module Models
  # Module contain custom error classes
  module Error
    class ArgumentNilError < ArgumentError; end

    class FieldRequiredError < ArgumentError; end

    class ValidationError < ArgumentError; end
  end
end

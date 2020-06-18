# frozen_string_literal: true

module Models
  module Error
    class ArgumentNilError < ArgumentError; end

    class FieldRequiredError < ArgumentError; end

    class ValidationError < ArgumentError; end
  end
end

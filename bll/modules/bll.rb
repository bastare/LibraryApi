# frozen_string_literal: true

# Module contain entites that implements BLL
module BLL
  # Module contain custom error classes
  module Error
    class ValidationError < ArgumentError
    end
  end
end

# frozen_string_literal: true

module BLL
  module Error
    class ValidationError < ArgumentError; end

    class ArgumentNilError < ArgumentError; end
  end
end

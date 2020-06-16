# frozen_string_literal: true

# Module contain classes that represent Data Accsess Layer
module DAL
  # Module contain custom error classes
  module Error
    class ArgumentNilError < ArgumentError
    end

    class IndexDuplicateError < ArgumentError
    end
  end
end

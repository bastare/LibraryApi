# frozen_string_literal: true

module DAL
  module Error
    class ArgumentNilError < ArgumentError; end

    class IndexDuplicateError < ArgumentError; end
  end
end

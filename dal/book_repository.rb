# typed: true
# frozen_string_literal: true

require_relative '../index'

module DAL
  class BookDAL < Repository
    def initialize(path)
      super path
    end
  end
end

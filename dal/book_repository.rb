# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that represent Data Accsess Layer
module DAL
  # Class 'book' contain api for communnication with data storage
  class BookDAL < Repository
    def initialize(path)
      super path
    end
  end
end

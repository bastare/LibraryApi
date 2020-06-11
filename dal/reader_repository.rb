# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that represent Data Accsess Layer
module DAL
  # Class 'reader' contain api for communnication with data storage
  class ReaderDAL < Repository
    def initialize(path)
      super path
    end
  end
end

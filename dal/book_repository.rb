# typed: true
# frozen_string_literal: true

require_relative './interfaces/repository'
# Module contain classes that represent Data Accsess Layer
module DAL
  # Class 'book' contain api for communnication with data storage
  class BookDAL < Repository
    def initialize
      super
    end
  end
end

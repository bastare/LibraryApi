# frozen_string_literal: true

require_relative './interfaces/repository'
# Module contain classes that represent Data Accsess Later
module DAL
  # Class 'reader' contain api for communnication with data storage
  class ReaderDAL < Repository
    def initialize
      super
    end
  end
end

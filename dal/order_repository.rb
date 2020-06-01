# frozen_string_literal: true

require_relative './interfaces/repository'
# Module contain classes that represent Data Accsess Later
module DAL
  # Class 'order' contain api for communnication with data storage
  class OrderDAL < Repository
    def initialize
      super
    end
  end
end

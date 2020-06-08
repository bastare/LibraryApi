# typed: true
# frozen_string_literal: true

require_relative './interfaces/repository'
# Module contain classes that represent Data Accsess Layer
module DAL
  # Class 'author' contain api for communnication with data storage
  class AuthorDAL < Repository
    def initialize
      super
    end
  end
end

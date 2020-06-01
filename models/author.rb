# frozen_string_literal: true

require 'yaml'

require_relative './interfaces/entity'
# Module contain classes that mapping with db entites
module Models
  # Class represent 'author' model
  class Author < Entity
    attr_reader :name, :biography

    def initialize(id, author)
      super id

      @name      = author[:name]
      @biography = author[:biography] || ''
    end
  end
end

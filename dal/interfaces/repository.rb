# frozen_string_literal: true

require_relative '../../index'

# Module contain classes that represent Data Accsess Layer
module DAL
  # Class represent abstraction for DAL entites
  class Repository
    attr_reader :path, :model

    def initialize(path)
      @path = path || raise(ArgumentNilError, 'No path given')

      @model = Models.fetch_class self.class.name[/(?<=::)[A-Za-z]+(?=DAL)/]
    end

    def fetch_all
      data = YAML.load_file(@path) || return

      data.find_all { |entity| entity&.kind_of? @model }
    end

    def fetch_entity(id)
      fetch_all&.find { |i| i&.id == id }
    end
  end
end

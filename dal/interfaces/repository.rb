# frozen_string_literal: true

require_relative '../../index'

module DAL
  class Repository
    attr_reader :path, :model

    def initialize(path)
      @path = path || raise(Error::ArgumentNilError, 'No path given')
    end

    def fetch_all
      data = YAML.load_file(@path) || return

      data.find_all { |entity| entity&.instance_of? model_type }
    end

    def fetch_entity(id)
      fetch_all&.find { |entity| entity&.id == id } || return
    end

    private

    def model_type
      Models.fetch_class self.class.name[/(?<=::)[A-Za-z]+(?=DAL)/] || raise(Error::ArgumentNilError, 'No `model`')
    end
  end
end

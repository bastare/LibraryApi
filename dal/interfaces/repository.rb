# frozen_string_literal: true

require_relative '../../index'

module DAL
  class Repository
    extend AbstractClass

    attr_reader :path, :model

    def initialize(path)
      @path = path || raise(Error::ArgumentNilError, 'No path given')
    end

    def fetch_all
      all_data = YAML.load_file(@path) || return

      all_data.find_all { |entity| entity.instance_of? fetch_model_klass }
    end

    def fetch_entity(id)
      fetch_all&.find { |entity| entity.id == id } || return
    end

    private

    def fetch_model_klass
      klass_name = self.class.name[/(?<=::)[A-Za-z]+(?=DAL)/]

      Models.fetch_klass(klass_name) || raise(Error::ArgumentNilError, "No `model` whith dis name #{klass_name}")
    end
  end
end

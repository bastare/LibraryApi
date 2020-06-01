# frozen_string_literal: true

# Module contain classes that represent Data Accsess Later
module DAL
  # Class represent abstraction for DAL entites
  class Repository
    attr_reader :path

    def initialize
      @path = db_path
    end

    def create(*entitys)
      file = File.new(@path, 'a')

      entitys.each do |entity|
        file.write(entity.to_yaml.gsub(/^---/, ''))
      end
    ensure
      file.close
    end

    def fetch_all
      YAML.load_file(@path)
    end

    def fetch_entity(id)
      result = YAML.load_file(@path)&.select { |i| i.id == id }

      result&.any? ? result.first : nil
    end

    private

    def db_path
      entity_name = self.class.name[/(?<=\W)[A-Z][a-z]+/].downcase

      local_path = "./db/#{entity_name}.yaml"

      File.new(local_path, 'w') unless File.exist? local_path

      local_path
    end
  end
end

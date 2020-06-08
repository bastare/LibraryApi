# typed: false
# frozen_string_literal: true

# Module contain classes that represent Data Accsess Layer
module DAL
  # Class represent abstraction for DAL entites
  class Repository
    attr_reader :path

    def initialize
      @path = create_db
    end

    def create(*entitys)
      file = File.new(@path, 'a')

      entitys.each do |entity|
        next if entity.nil?

        entity = entity.to_a unless entity.is_a? Array

        file.write(entity.to_yaml.gsub(/^---/, ''))
      end
    ensure
      file.close
    end

    def fetch_all
      YAML.load_file(@path)
    end

    def fetch_entity(id)
      result = YAML.load_file(@path)&.select { |i| i&.id == id }

      result&.empty? ? result.first : nil
    end

    private

    def create_db
      entity_name = self.class.name[/(?<=\W)[A-Z][a-z]+/].downcase

      db_path = "./db/#{entity_name}.yaml"

      File.new(db_path, 'w') unless File.exist? db_path

      db_path
    end
  end
end

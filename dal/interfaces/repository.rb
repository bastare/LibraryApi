# typed: false
# frozen_string_literal: true

require_relative '../../helpers/configuration'
# Module contain classes that represent Data Accsess Layer
module DAL
  # Class represent abstraction for DAL entites
  class Repository
    attr_reader :path

    def initialize
      @path = create_db(Helper.db_path)
    end

    def create(entitys)
      raise ArgumentError, 'Value is nil' if entitys.nil?

      entitys.uniq!(&:id)

      file = File.new(@path, 'w')

      entitys.each do |entity|
        next if entity.nil?

        entity = [entity] unless entity.is_a? Array

        file.write(entity.to_yaml.gsub(/^---/, ''))
      end
    ensure
      file&.close
    end

    def fetch_all
      YAML.load_file(@path) || nil
    end

    def fetch_entity(id)
      fetch_all&.find { |i| i&.id == id }
    end

    private

    def create_db(db_folder)
      raise ArgumentError, 'Wrong conf' if db_folder.nil?

      db_path = form_path(db_folder)

      File.new(db_path, 'w') unless File.exist? db_path

      db_path
    end

    def form_path(db_folder)
      Dir.mkdir db_folder unless Dir.exist?(db_folder)

      entity_name = self.class.name[/(?<=\W)[A-Z][a-z]+/]&.downcase || raise(StandardError, 'Wrong entity name')

      "#{db_folder}/#{entity_name}.yaml"
    end
  end
end

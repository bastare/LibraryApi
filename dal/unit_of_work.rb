# typed: true
# frozen_string_literal: true

require_relative '../index'

# Module contain classes that represent Data Accsess Layer
module DAL
  # Unit of DAL entites
  class UnitOfWork
    attr_reader :author, :book, :order, :reader

    def initialize
      @path = DAL.create_db(Helper.db_path)

      @author = AuthorDAL.new @path
      @book   = BookDAL.new   @path
      @order  = OrderDAL.new  @path
      @reader = ReaderDAL.new @path
    end

    def save(*entitys_lists)
      index_validation entitys_lists

      entitys_lists.flatten!

      File.open(@path, 'w') { |f| f.write(entitys_lists.to_yaml) }
    end

    private

    def index_validation(entitys_lists)
      raise ArgumentNilError, 'Value is nil' if entitys.nil?

      entitys_lists.each do |entitys|
        unless entitys.uniq(&:id).length == entitys.length
          raise(IndexDuplicateError, "Collection of #{entitys.first.class} contain entity, with duplicate index")
        end
      end
    end
  end
end

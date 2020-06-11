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

    def save(*entitys)
      entitys&.flatten! || raise(ArgumentNilError, 'Value is nil')

      File.open(@path, 'w') { |f| f.write(entitys.to_yaml) }
    end
  end
end

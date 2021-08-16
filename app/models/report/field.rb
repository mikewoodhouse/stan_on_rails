# frozen_string_literal: true

module Report
  class Field
    def initialize(coldef = {})
      @key = coldef['field']
      @heading = coldef['heading'] || @key.capitalize
      @cls = coldef['cls'] || (@key == 'name' ? 'name' : 'number')
      @format = coldef['format']
      @sort = coldef['sort']
    end

    def to_h
      {
        key: @key,
        heading: @heading,
        cls: @cls,
        format: @format,
        sort: @sort
      }
    end
  end
end

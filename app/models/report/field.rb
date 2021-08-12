# frozen_string_literal: true

module Report
  class Field
    class << self
      def from_h(coldef)
        new(
          coldef['field'],
          coldef['heading'],
          coldef['class'],
          coldef['format'],
        )
      end
    end

    def initialize(key, heading = nil, cls = nil, format = nil)
      @key = key
      @heading = heading || key.capitalize
      @cls = cls || (key == 'name' ? 'name' : 'number')
      @format = format
    end

    def to_h
      {
        key: @key,
        heading: @heading,
        cls: @cls,
        format: @format
      }
    end
  end
end
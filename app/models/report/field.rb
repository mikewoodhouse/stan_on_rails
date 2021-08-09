# frozen_string_literal: true

module Report
  class Field
    class << self
      def from_h(h)
        new(
          h[:field],
          h[:heading],
          h[:class],
          h[:format],
        )
      end
    end

    def initialize(key, heading = nil, cls = nil, format = nil)
      @key = key
      @heading = heading
      @cls = cls
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
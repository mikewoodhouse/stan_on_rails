class Report
  class Field
    def initialize(key, heading = nil, cls = nil)
      @key, @heading, @cls = key, heading, cls
    end

    def to_h
      {
        key: @key,
        heading: @heading,
        cls: @cls,
      }
    end
  end
end

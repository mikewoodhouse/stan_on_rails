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

  def initialize
    @title = "No Title"
    @subtitle = ""
    @columns = []
  end

  def execute(binds = [])
    @rows = ActiveRecord::Base.connection.exec_query(sql, self.class.name, binds = binds)
  end

  def sql
    ""
  end

  def to_h
    {
      "title" => @title,
      "subtitle" => @subtitle,
      "columns" => @columns.map(&:to_h),
      "data" => @rows.to_a,
    }
  end
end

# frozen_string_literal: true

module Report
  class Base
    class Field
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

    def initialize(params)
      @title = 'No Title'
      @subtitle = ''
      @columns = []
      @params = params
    end

    def execute(query_binds = [])
      @rows = ActiveRecord::Base.connection.exec_query(sql, self.class.name, query_binds)
    end

    def sql
      ''
    end

    def to_h
      {
        'title' => @title,
        'subtitle' => @subtitle,
        'columns' => @columns.map(&:to_h),
        'data' => @rows.to_a
      }
    end
  end
end

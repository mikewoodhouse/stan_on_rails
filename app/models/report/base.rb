# frozen_string_literal: true

module Report
  class Base
    attr_accessor :title,  :subtitle,  :columns,  :sql

    class << self
      def from_spec(s, params)
        r = new(params)
        puts s
        r.title = s.title
        r.subtitle = s.subtitle
        r.columns = s.columns
        r.sql = s.sql
        return r
      end
    end

    def initialize(params)
      @title = 'No Title'
      @subtitle = ''
      @columns = []
      @params = params
      @sql = ''
    end

    def execute(query_binds = [])
      puts "sql=#{@sql}"
      puts @title
      @rows = ActiveRecord::Base.connection.exec_query(@sql, @title, query_binds)
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

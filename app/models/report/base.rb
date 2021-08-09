# frozen_string_literal: true

module Report
  class Base
    attr_accessor :title, :subtitle, :columns, :params, :parameters, :sql

    class << self
      def from_spec(s)
        new.tap do |r|
          r.title = s.title
          r.subtitle = s.subtitle
          r.columns = s.columns
          r.parameters = s.parameters
          r.sql = s.sql
        end
      end
    end

    def execute(params = {})
      @params = params
      query_binds = @parameters ? @parameters.map { |p, dflt| params[p] || dflt} : []
      @rows = ActiveRecord::Base.connection.exec_query(@sql, @title, query_binds)
    end

    def to_h
      {
        'title' => @title,
        'subtitle' => @subtitle,
        'columns' => @columns.map(&:to_h),
        'data' => @rows.to_a,
        'params' => @params,
      }
    end
  end
end

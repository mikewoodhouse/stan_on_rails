# frozen_string_literal: true

module Report
  class Base
    attr_accessor :key, :title, :subtitle, :columns, :params, :query_filters, :sql

    class << self
      def from_spec(s)
        new.tap do |r|
          r.key = s.key
          r.title = s.title
          r.subtitle = s.subtitle
          r.columns = s.columns
          r.query_filters = s.query_filters
          r.sql = s.sql
        end
      end
    end

    def execute(params = {})
      @params = params
      query_binds = query_filters.map { |qf| params[qf.desc] || qf.default }
      puts "query_binds=#{query_binds}"
      @rows = ActiveRecord::Base.connection.exec_query(@sql, @title, query_binds)
    end

    def to_h
      {
        'key' => @key,
        'title' => @title,
        'title' => parameterize(@title),
        'subtitle' => @subtitle,
        'columns' => @columns.map(&:to_h),
        'data' => @rows.to_a,
        'params' => @params,
        'filters' => @query_filters
      }
    end

    def parameterize(template)
      regexp = /\{.+\}/
      param = template[regexp]
      return template unless param

      param_name = param.gsub(/[\{\}]/, '')
      template.gsub(param, @params[param_name])
    end
  end
end
